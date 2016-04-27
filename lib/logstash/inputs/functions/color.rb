# encoding: utf-8
require 'faker'

module LogStash; module Inputs; class Functions;
  class Color

    def self.parse_color(data)
      if data["type"].downcase == "hex_color"
        gen_hex_color
      elsif data["type"].downcase == "color_name"
        gen_color_name
      elsif data["type"].downcase == "rgb_color"
        gen_rgb_color
      elsif data["type"].downcase == "hsl_color"
        gen_hsl_color
      elsif data["type"].downcase == "hsla_color"
        gen_hsla_color
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.gen_hex_color
      return Faker::Color.hex_color
    end

    def self.gen_color_name
      return Faker::Color.color_name
    end

    def self.gen_rgb_color
      return Faker::Color.rgb_color
    end

    def self.gen_hsl_color
      return Faker::Color.hsl_color
    end

    def self.gen_hsla_color
      return Faker::Color.hsla_color
    end

  end
end;  end; end
