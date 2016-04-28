# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Internet

    # parse internet type
    def self.parse(data)
        if data["type"].downcase == "ipv4"
          gen_ipv4(data)
        elsif data["type"].downcase == "ipv6"
          gen_ipv6(data)
        elsif data["type"].downcase == "email"
          gen_email(data)
        elsif data["type"].downcase == "username"
          gen_username
        elsif data["type"].downcase == "password"
          gen_password(data)
        elsif data["type"].downcase == "domain"
          gen_domain(data)
        elsif data["type"].downcase == "mac_address"
          gen_mac_address
        elsif data["type"].downcase == "url"
          gen_url(data)
        else
          @value = "INVALID INTERNET TYPE"
        end
    end

    ############################
    ## custom functions below ##
    ############################
    # ip data
    def self.gen_ipv4(data)
      if !data["sub-type"].nil? && data["sub-type"].downcase == "ipv4_cidr"
        return Faker::Internet.ip_v4_cidr
      else
        return IPAddr.new(rand(2**32),Socket::AF_INET).to_s
      end
    end

    def self.gen_ipv6(data)
      if !data["sub-type"].nil? && data["sub-type"].downcase == "ipv6_cidr"
        return Faker::Internet.ip_v6_cidr
      else
        return IPAddr.new(rand(2**128),Socket::AF_INET6).to_s
      end
    end

    # email data
    def self.gen_email(data)
      if !data["properties"].nil? && !data["properties"]["name"].nil?
        @name = data["properties"]["name"]
        return Faker::Internet.free_email(@name)
      else
          return Faker::Internet.free_email
      end
    end

    # user_name
    def self.gen_username
      return Faker::Internet.user_name
    end

    # password
    def self.gen_password(data)
      if !data["properties"].nil? && !data["properties"]["min"].nil? && !data["properties"]["max"].nil? && !data["properties"]["special_chars"].nil?
        @min = data["properties"]["min"]
        @max = data["properties"]["max"]
        Faker::Internet.password(@min, @max, true, true)
      elsif !data["properties"].nil? && !data["properties"]["min"].nil? && !data["properties"]["max"].nil?
        @min = data["properties"]["min"]
        @max = data["properties"]["max"]
        Faker::Internet.password(@min, @max)
      else
        Faker::Internet.password
      end
    end

    # domain
    def self.gen_domain(data)
      if !data["sub-type"].nil? && data["sub-type"].downcase == "domain_word"
        return Faker::Internet.domain_word
      elsif !data["sub-type"].nil? && data["sub-type"].downcase == "domain_suffix"
        return Faker::Internet.domain_suffix
      else
        return Faker::Internet.domain_name
      end
    end

    # mac_address
    def self.gen_mac_address
      return Faker::Internet.mac_address
    end

    # url
    def self.gen_url(data)
      if !data["properties"].nil? && !data["properties"]["domain"].nil? && !data["properties"]["uri"].nil?
        @domain = data["properties"]["domain"]
        @uri = data["properties"]["uri"]
        return Faker::Internet.url(@domain, @uri)
      elsif !data["properties"].nil? && !data["properties"]["domain"].nil? && !data["properties"]["uri"].nil?
        @domain = data["properties"]["domain"]
        return Faker::Internet.url(@domain)
      else
        return Faker::Internet.url
      end

    end

  end
end;  end; end
