# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Finance

    def self.parse(data)
      if data["type"].downcase == "credit_card_number"
        credit_card_number(data)
      elsif data["type"].downcase == "credit_card_type"
        credit_card_type
      elsif data["type"].downcase == "credit_card_expiry"
        credit_card_expiry
      elsif data["type"].downcase == "bitcoin_address"
        bitcoin_address
      elsif data["type"].downcase == "bitcoin_testnet_address"
        bitcoin_testnet_address
      else
        @value = "INVALID FINANCE TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.credit_card_number(data)
      @card_number = Faker::Finance.credit_card(data["make"])
      @card_number.gsub! '-', ''
      return @card_number
    end

    def self.credit_card_type
      return Faker::Business.credit_card_type
    end

    def self.credit_card_expiry
      return Faker::Business.credit_card_expiry_date.to_s
    end

    def self.bitcoin_address
      return Faker::Bitcoin.address
    end

    def self.bitcoin_testnet_address
      return Faker::Bitcoin.testnet_address
    end

  end
end;  end; end
