# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Address

    def self.parse(data)
      if data["type"].downcase == "city"
        city
      elsif data["type"].downcase == "street_name"
        street_name
      elsif data["type"].downcase == "street_address"
        street_address
      elsif data["type"].downcase == "secondary_address"
        secondary_address
      elsif data["type"].downcase == "building_number"
        building_number
      elsif data["type"].downcase == "zip_code"
        zip_code
      elsif data["type"].downcase == "zip"
        zip
      elsif data["type"].downcase == "postcode"
        postcode
      elsif data["type"].downcase == "time_zone"
        time_zone
      elsif data["type"].downcase == "street_suffix"
        street_suffix
      elsif data["type"].downcase == "city_prefix"
        city_prefix
      elsif data["type"].downcase == "city_suffix"
        city_suffix
      elsif data["type"].downcase == "state"
        state
      elsif data["type"].downcase == "state_abbr"
        state_abbr
      elsif data["type"].downcase == "country"
        country
      elsif data["type"].downcase == "country_code"
        country_code
      elsif data["type"].downcase == "latitude"
        latitude
      elsif data["type"].downcase == "longitude"
        longitude
      else
        @value = "INVALID ADDRESS TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.city
      return Faker::Address.city
    end

    def self.street_name
      return Faker::Address.city
    end

    def self.street_address
      return Faker::Address.street_address
    end

    def self.secondary_address
      return Faker::Address.secondary_address
    end

    def self.building_number
      return Faker::Address.building_number
    end

    def self.zip_code
      return Faker::Address.zip_code
    end

    def self.zip
      return Faker::Address.zip
    end

    def self.postcode
      return Faker::Address.postcode
    end

    def self.time_zone
      return Faker::Address.time_zone
    end

    def self.street_suffix
      return Faker::Address.street_suffix
    end

    def self.city_prefix
      return Faker::Address.city_prefix
    end

    def self.city_suffix
      return Faker::Address.city_suffix
    end

    def self.state
      return Faker::Address.state
    end

    def self.state_abbr
      return Faker::Address.state_abbr
    end

    def self.country
      return Faker::Address.country
    end

    def self.country_code
      return Faker::Address.country_code
    end

    def self.latitude
      return Faker::Address.latitude
    end

    def self.longitude
      return Faker::Address.longitude
    end

  end
end;  end; end
