# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname
require "json"
require 'ipaddr'
require 'faker'

# bug with faker - https://github.com/stympy/faker/issues/278
I18n.reload!

# Generate a repeating message.
#
# This plugin is intented only as an example.

class LogStash::Inputs::Generator < LogStash::Inputs::Base
  config_name "generator"

  # If undefined, Logstash will complain, even if codec is unused.
  default :codec, "plain"

  ## Logstash Config Params ##

  # The message string to use in the event.
  config :message, :validate => :string, :default => "Hello World!"

  # Set how frequently messages should be sent.
  #
  # The default, `1`, means send a message every second.
  config :event_interval, :validate => :number, :default => 1

  # The full path of the external schema file. The format of the table
  # should be a standard JSON file.
  # NOTE: The JSON format only supports simple key/value, unnested objects.
  config :schema_path, :validate => :path

  # When using a schema file, this setting will indicate how frequently
  # (in seconds) logstash will check the schema file for updates.
  config :schema_refresh_interval, :validate => :number, :default => 1

  ## Logstash Config Params ##

  public
  def register
    @host = Socket.gethostname

    # reload schema
    if @schema_path
      @next_refresh = Time.now + @schema_refresh_interval
      raise_exception = true
      load_schema(raise_exception)
    end
  end

  def run(queue)
    # we can abort the loop if stop? becomes true
    while !stop?
      # reload schema
      if @schema_path
        if @next_refresh < Time.now
          load_schema
          @next_refresh = Time.now + @schema_refresh_interval
          @logger.info("refreshing schema")
        end
      end

      # set faker locale
      Faker::Config.locale = @schema["locale"]
      # create output hash
      @event_output = Hash.new
      # add defulat items to event
      @event_output["message"] = @message
      @event_output["host"] = @host

      @schema["fields"].each do |fields|
        # set key
        @key = fields["key"]

        # parse event schema
        if fields["type"].downcase == "string"
          @value = fields["value"]
        elsif fields["type"].downcase == "integer"
          @value = parse_int(fields)
        elsif fields["type"].downcase == "ipv4"
          @value = gen_ipv4(fields)
        elsif fields["type"].downcase == "ipv6"
          @value = gen_ipv6(fields)
        elsif fields["type"].downcase == "credit_card"
          @value = gen_credit_card(fields)
        end

        # append values to hash value
        @event_output[@key] = @value
      end

      event = LogStash::Event.new(@event_output)
      decorate(event)
      queue << event
      Stud.stoppable_sleep(@schema["event_speed"]) { stop? }
    end
  end

  def parse_int(data)
    if data["range"]
      @min = data["range"]["min"]
      @max = data["range"]["max"]
      return rand(@min..@max)
    elsif data["random"]
      # TODO -- specify size ? Is that not a range?
      return rand(1000000000000000000)
    else
      return data["value"]
    end
  end

  def gen_ipv4(data)
    if data["random"]
        return IPAddr.new(rand(2**32),Socket::AF_INET).to_s
    else
        return data["value"]
    end

  end

  def gen_ipv6(data)
    return IPAddr.new(rand(2**128),Socket::AF_INET6).to_s
  end

  def gen_credit_card(data)
    @card_number = Faker::Finance.credit_card("visa")
    @card_number.gsub! '-', ''
    return @card_number
  end

  def load_schema(raise_exception=false)
    if @schema_path.end_with?(".json")
      load_json(raise_exception)
    else
      raise "#{self.class.name}: schema #{@schema_path} have a non valid format"
    end
  rescue => e
    loading_exception(e, raise_exception)
  end

  def load_json(raise_exception=false)
    if !File.exists?(@schema_path)
      @logger.warn("schema file read failure, continuing with old schema", :path => @schema_path)
      return
    end
    merge_schema!(JSON.parse(File.read(@schema_path)), raise_exception)
  end

  def merge_schema!(data, raise_exception=false)
      @schema = data
  end

  def loading_exception(e, raise_exception=false)
    msg = "#{self.class.name}: #{e.message} when loading schema file at #{@schema_path}"
    if raise_exception
      raise RuntimeError.new(msg)
    else
      @logger.warn("#{msg}, continuing with old schema", :schema_path => @schema_path)
    end
  end

  def stop
    # nothing to do in this case so it is not necessary to define stop
    # examples of common "stop" tasks:
    #  * close sockets (unblocking blocking reads/accepts)
    #  * cleanup temporary files
    #  * terminate spawned threads
  end
end
