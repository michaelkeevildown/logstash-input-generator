# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class FakerFunctions

    def self.parse_common(data)
      if data["type"].downcase == "string"
        return data["value"]
      elsif data["type"].downcase == "integer"
        parse_int(data)
      end
    end

    def self.parse_internet(data)
        if data["type"].downcase == "ipv4"
          gen_ipv4(data)
        elsif data["type"].downcase == "ipv6"
          gen_ipv6(data)
        end
    end

    def self.parse_banking(data)
      if data["type"].downcase == "credit_card"
        gen_credit_card(data)
      end
    end

    def self.parse_int(data)
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

    def self.gen_ipv4(data)
      if data["random"]
          return IPAddr.new(rand(2**32),Socket::AF_INET).to_s
      else
          return data["value"]
      end

    end

    def self.gen_ipv6(data)
      return IPAddr.new(rand(2**128),Socket::AF_INET6).to_s
    end

    def self.gen_credit_card(data)
      @card_number = Faker::Finance.credit_card("visa")
      @card_number.gsub! '-', ''
      return @card_number
    end

  end
end;  end; end
