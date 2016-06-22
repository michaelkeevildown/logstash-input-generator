# encoding: utf-8
require 'ipaddr'
require 'faker'

module LogStash; module Inputs; class Functions;
  class Internet

    # parse internet type
    def self.parse(data)
        if data["type"].downcase == "ipv4"
          ipv4(data)
        elsif data["type"].downcase == "ipv6"
          ipv6(data)
        elsif data["type"].downcase == "email"
          email(data)
        elsif data["type"].downcase == "username"
          username
        elsif data["type"].downcase == "password"
          password(data)
        elsif data["type"].downcase == "domain"
          domain(data)
        elsif data["type"].downcase == "mac_address"
          mac_address
        elsif data["type"].downcase == "url"
          url(data)
        elsif data["type"].downcase == "port"
          port
        else
          @value = "INVALID INTERNET TYPE"
        end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.ipv4(data)
      if !data["sub-type"].nil? && data["sub-type"].downcase == "ipv4_cidr"
        return Faker::Internet.ip_v4_cidr
      elsif !data["sub-type"].nil? && data["sub-type"].downcase == "ipv4_internal"
        part2 = Faker::Number.between(0, 254)
        part3 = Faker::Number.between(0, 254)
        part4 = Faker::Number.between(1, 254)
        return "10.#{part2}.#{part3}.#{part4}"
      else
        return IPAddr.new(rand(2**32),Socket::AF_INET).to_s
      end
    end

    def self.ipv6(data)
      if !data["sub-type"].nil? && data["sub-type"].downcase == "ipv6_cidr"
        return Faker::Internet.ip_v6_cidr
      else
        return IPAddr.new(rand(2**128),Socket::AF_INET6).to_s
      end
    end

    def self.email(data)
      if !data["properties"].nil? && !data["properties"]["name"].nil?
        @name = data["properties"]["name"]
        return Faker::Internet.free_email(@name)
      else
          return Faker::Internet.free_email
      end
    end

    def self.username
      return Faker::Internet.user_name
    end

    def self.password(data)
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

    def self.domain(data)
      if !data["sub-type"].nil? && data["sub-type"].downcase == "domain_word"
        return Faker::Internet.domain_word
      elsif !data["sub-type"].nil? && data["sub-type"].downcase == "domain_suffix"
        return Faker::Internet.domain_suffix
      else
        return Faker::Internet.domain_name
      end
    end

    def self.mac_address
      return Faker::Internet.mac_address
    end

    def self.url(data)
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

    def self.port
      @min = 0
      @max = 65536
      return rand(@min..@max)
    end

  end
end;  end; end
