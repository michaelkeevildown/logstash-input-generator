# encoding: utf-8
require "logstash/inputs/base"
require "logstash/namespace"
require "stud/interval"
require "socket" # for Socket.gethostname
require "json"

# bug with faker - https://github.com/stympy/faker/issues/278
I18n.reload!

class LogStash::Inputs::Generator < LogStash::Inputs::Base
  require "logstash/inputs/functions/common"
  require "logstash/inputs/functions/finance"
  require "logstash/inputs/functions/internet"
  require "logstash/inputs/functions/address"
  require "logstash/inputs/functions/color"
  require "logstash/inputs/functions/commerce"
  require "logstash/inputs/functions/lorem"
  require "logstash/inputs/functions/person"
  require "logstash/inputs/functions/date"

  config_name "generator"

  # If undefined, Logstash will complain, even if codec is unused.
  default :codec, "plain"

  ## Logstash Config Params ##

  # The full path of the external schema file. The format of the table
  # should be a standard JSON file.
  # NOTE: The JSON format only supports simple key/value, unnested objects.
  config :schema_path, :validate => :path, :required => true

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
      if @next_refresh < Time.now
        load_schema
        @next_refresh = Time.now + @schema_refresh_interval
        @logger.info("refreshing schema")
      end


      # set faker locale
      Faker::Config.locale = @schema["locale"]
      # create output hash
      @event_output = Hash.new

      # call loop function
      @event_output = loop_params(@schema)

      # add defulat items to event
      @event_output["host"] = @host
      event = LogStash::Event.new(@event_output)
      decorate(event)
      queue << event
      Stud.stoppable_sleep(@schema["events_per_second"]) { stop? }
    end
  end

  def loop_params(schema)
    new_parent = Hash.new
    schema["fields"].each do |field|
      new_key = field["key"]
      if !field["group"].nil? && field["object"].nil?
        new_parent[new_key] = parse_config(field)
      else
        if field["repeat"].nil? or field["repeat"] < 2
          new_parent[new_key] = loop_params(field)
        else
          repeat = field["repeat"]
          array = Array.new
          repeat.times do |i|
            hash = Hash.new
            hash = loop_params(field)
            array << hash
          end
          new_parent[new_key] = array
        end
      end
    end
    return new_parent
  end

  def parse_config(fields)
    # parse event schema
    if fields["group"].downcase == "common"
      @value = ::LogStash::Inputs::Functions::Common.parse(fields)
    elsif fields["group"].downcase == "internet"
      @value = ::LogStash::Inputs::Functions::Internet.parse(fields)
    elsif fields["group"].downcase == "finance"
      @value = ::LogStash::Inputs::Functions::Finance.parse(fields)
    elsif fields["group"].downcase == "address"
      @value = ::LogStash::Inputs::Functions::Address.parse(fields)
    elsif fields["group"].downcase == "color"
      @value = ::LogStash::Inputs::Functions::Color.parse(fields)
    elsif fields["group"].downcase == "commerce"
      @value = ::LogStash::Inputs::Functions::Commerce.parse(fields)
    elsif fields["group"].downcase == "lorem"
      @value = ::LogStash::Inputs::Functions::Lorem.parse(fields)
    elsif fields["group"].downcase == "person"
      @value = ::LogStash::Inputs::Functions::Person.parse(fields)
    elsif fields["group"].downcase == "date"
      @value = ::LogStash::Inputs::Functions::Dates.parse(fields)
    else
      @value = "INVALID GROUP"
    end
      return @value
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
