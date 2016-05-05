# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Common

    def self.parse(data)
      if data["type"].downcase == "string"
        return data["value"]
      elsif data["type"].downcase == "integer"
        integer(data)
      elsif data["type"].downcase == "random_list"
        random_list(data)
      elsif data["type"].downcase == "hex"
        hex(data)
      else
        @value = "INVALID COMMON TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.integer(data)

      if !data["properties"].nil? && !data["properties"]["range"].nil? && !data["properties"]["range"]["min"].nil? && !data["properties"]["range"]["max"].nil?
        min = data["properties"]["range"]["min"]
        max = data["properties"]["range"]["max"]
        return rand(min..max)

      elsif !data["properties"].nil? && data["properties"]["digits"]
        digits = data["properties"]["digits"]
        decimals = data["properties"]["decimals"]
        if data["properties"]["negative"]
          number = Faker::Number.decimal(digits, decimals).to_f * -1
        else
          number = Faker::Number.decimal(digits, decimals).to_f
        end
        return number

      elsif !data["properties"].nil? && data["properties"]["between"]
        from = data["properties"]["from"]
        to = data["properties"]["to"]
        return Faker::Number.between(from, to)

      else
        return data["value"]
      end

    end

    def self.random_list(data)
      if !data["properties"].nil? && !data["properties"]["list"].nil?
        list = data["properties"]["list"]
        return list.sample
      else
        return "INVALID LIST"
      end
    end

    def self.hex(data)
      size = data["properties"]["size"]
      return Faker::Number.hexadecimal(size)
    end

  end
end;  end; end
