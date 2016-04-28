# encoding: utf-8
require 'faker'

module LogStash; module Inputs; class Functions;
  class Commerce

    def self.parse(data)
      if data["type"].downcase == "department"
        gen_department
      elsif data["type"].downcase == "product_name"
        gen_product_name
      elsif data["type"].downcase == "price"
        gen_price
      else
        @value = "INVALID COMMERCE TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.gen_department
      return Faker::Commerce.department
    end

    def self.gen_product_name
      return Faker::Commerce.product_name
    end

    def self.gen_price
      return Faker::Commerce.price
    end

  end
end;  end; end
