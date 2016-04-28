# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Address

    def self.parse(data)
      if data["type"].downcase == "city"
        gen_city
      elsif data["type"].downcase == "street_name"
        gen_street_name
      elsif data["type"].downcase == "street_address"
        gen_street_address
      elsif data["type"].downcase == "secondary_address"
        gen_secondary_address
      elsif data["type"].downcase == "building_number"
        gen_building_number
      elsif data["type"].downcase == "zip_code"
        gen_zip_code
      elsif data["type"].downcase == "zip"
        gen_zip
      elsif data["type"].downcase == "postcode"
        gen_postcode
      elsif data["type"].downcase == "time_zone"
        gen_time_zone
      elsif data["type"].downcase == "street_suffix"
        gen_street_suffix
      elsif data["type"].downcase == "city_prefix"
        gen_city_prefix
      elsif data["type"].downcase == "city_suffix"
        gen_city_suffix
      elsif data["type"].downcase == "state"
        gen_state
      elsif data["type"].downcase == "state_abbr"
        gen_state_abbr
      elsif data["type"].downcase == "country"
        gen_country
      elsif data["type"].downcase == "country_code"
        gen_country_code
      elsif data["type"].downcase == "latitude"
        gen_latitude
      elsif data["type"].downcase == "longitude"
        gen_longitude
      else
        @value = "INVALID ADDRESS TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.gen_city
      return Faker::Address.city
    end

    def self.gen_street_name
      return Faker::Address.city
    end

    def self.gen_street_address
      return Faker::Address.street_address
    end

    def self.gen_secondary_address
      return Faker::Address.secondary_address
    end

    def self.gen_building_number
      return Faker::Address.building_number
    end

    def self.gen_zip_code
      return Faker::Address.zip_code
    end

    def self.gen_zip
      return Faker::Address.zip
    end

    def self.gen_postcode
      return Faker::Address.postcode
    end

    def self.gen_time_zone
      return Faker::Address.time_zone
    end

    def self.gen_street_suffix
      return Faker::Address.street_suffix
    end

    def self.gen_city_prefix
      return Faker::Address.city_prefix
    end

    def self.gen_city_suffix
      return Faker::Address.city_suffix
    end

    def self.gen_state
      return Faker::Address.state
    end

    def self.gen_state_abbr
      return Faker::Address.state_abbr
    end

    def self.gen_country
      return Faker::Address.country
    end

    def self.gen_country_code
      return Faker::Address.country_code
    end

    def self.gen_latitude
      return Faker::Address.latitude
    end

    def self.gen_longitude
      return Faker::Address.longitude
    end

  end
end;  end; end
