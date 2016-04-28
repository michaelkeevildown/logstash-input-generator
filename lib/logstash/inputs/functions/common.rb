# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Common

    def self.parse(data)
      if data["type"].downcase == "string"
        return data["value"]
      elsif data["type"].downcase == "integer"
        int(data)
      elsif data["type"].downcase == "random_list"
        random_list(data)
      else
        @value = "INVALID COMMON TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.int(data)
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

    def self.random_list(data)
      if !data["properties"].nil? && !data["properties"]["list"].nil?
        @list = data["properties"]["list"]
        return @list.sample
      else
        return "INVALID LIST"
      end
    end

  end
end;  end; end
