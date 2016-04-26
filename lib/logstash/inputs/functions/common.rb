# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Common

    def self.parse_common(data)
      if data["type"].downcase == "string"
        return data["value"]
      elsif data["type"].downcase == "integer"
        parse_int(data)
      end
    end

    ############################
    ## custom functions below ##
    ############################
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

  end
end;  end; end
