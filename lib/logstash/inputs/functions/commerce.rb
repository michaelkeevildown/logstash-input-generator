# encoding: utf-8
require 'faker'

module LogStash; module Inputs; class Functions;
  class Commerce

    def self.parse(data)
      if data["type"].downcase == "department"
        department
      elsif data["type"].downcase == "product_name"
        product_name
      elsif data["type"].downcase == "price"
        price
      else
        @value = "INVALID COMMERCE TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.department
      return Faker::Commerce.department
    end

    def self.product_name
      return Faker::Commerce.product_name
    end

    def self.price
      return Faker::Commerce.price
    end

  end
end;  end; end
