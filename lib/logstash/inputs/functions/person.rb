# encoding: utf-8
require 'faker'

module LogStash; module Inputs; class Functions;
  class Person

    def self.parse(data)
      if data["type"].downcase == "name"
        name
      elsif data["type"].downcase == "first_name"
        first_name
      elsif data["type"].downcase == "last_name"
        last_name
      elsif data["type"].downcase == "prefix"
        prefix
      elsif data["type"].downcase == "suffix"
        suffix
      elsif data["type"].downcase == "title"
        title
      else
        @value = "INVALID PERSON TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.name
      return Faker::Name.name
    end

    # faker funciton not working - fix later
    # def self.name_with_middle
    #   return Faker::Name.name_with_middle
    # end

    def self.first_name
      return Faker::Name.first_name
    end

    def self.last_name
      return Faker::Name.last_name
    end

    def self.prefix
      return Faker::Name.prefix
    end

    def self.suffix
      return Faker::Name.suffix
    end

    def self.title
      return Faker::Name.title
    end

  end
end;  end; end
