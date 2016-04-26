# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Banking

    def self.parse_banking(data)
      if data["type"].downcase == "credit_card_number"
        gen_credit_card_number(data)
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

  end
end;  end; end
