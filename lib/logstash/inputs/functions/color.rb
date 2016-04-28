# encoding: utf-8
require 'faker'

module LogStash; module Inputs; class Functions;
  class Color

    def self.parse(data)
      if data["type"].downcase == "hex_color"
        hex_color
      elsif data["type"].downcase == "color_name"
        color_name
      elsif data["type"].downcase == "rgb_color"
        rgb_color
      elsif data["type"].downcase == "hsl_color"
        hsl_color
      elsif data["type"].downcase == "hsla_color"
        hsla_color
      else
        @value = "INVALID COLOR TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.hex_color
      return Faker::Color.hex_color
    end

    def self.color_name
      return Faker::Color.color_name
    end

    def self.rgb_color
      return Faker::Color.rgb_color
    end

    def self.hsl_color
      return Faker::Color.hsl_color
    end

    def self.hsla_color
      return Faker::Color.hsla_color
    end

  end
end;  end; end
