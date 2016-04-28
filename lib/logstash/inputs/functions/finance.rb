# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Finance

    def self.parse(data)
      if data["type"].downcase == "credit_card_number"
        gen_credit_card_number(data)
      elsif data["type"].downcase == "credit_card_type"
        gen_credit_card_type
      elsif data["type"].downcase == "credit_card_expiry"
        gen_credit_card_expiry
      elsif data["type"].downcase == "bitcoin_address"
        gen_bitcoin_address
      elsif data["type"].downcase == "bitcoin_testnet_address"
        gen_bitcoin_testnet_address
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.gen_credit_card_number(data)
      @card_number = Faker::Finance.credit_card(data["make"])
      @card_number.gsub! '-', ''
      return @card_number
    end

    def self.gen_credit_card_type
      return Faker::Business.credit_card_type
    end

    def self.gen_credit_card_expiry
      return Faker::Business.credit_card_expiry_date.to_s
    end

    def self.gen_bitcoin_address
      return Faker::Bitcoin.address
    end

    def self.gen_bitcoin_testnet_address
      return Faker::Bitcoin.testnet_address
    end

  end
end;  end; end
