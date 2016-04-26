# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Internet

    # parse internet type
    def self.parse_internet(data)
        if data["type"].downcase == "ipv4"
          gen_ipv4(data)
        elsif data["type"].downcase == "ipv6"
          gen_ipv6(data)
        end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.gen_ipv4(data)
      if data["random"]
          return IPAddr.new(rand(2**32),Socket::AF_INET).to_s
      else
          return data["value"]
      end

    end

    def self.gen_ipv6(data)
      return IPAddr.new(rand(2**128),Socket::AF_INET6).to_s
    end

  end
end;  end; end
