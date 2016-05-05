# encoding: utf-8
require 'faker'

module LogStash; module Inputs; class Functions;
  class Dates

    def self.parse(data)
      if data["type"].downcase == "future_date"
        future_date(data)
      elsif data["type"].downcase == "past_date"
        past_date(data)
      elsif data["type"].downcase == "between_date"
        between_date(data)
      elsif data["type"].downcase == "future_date_time"
        future_date_time(data)
      elsif data["type"].downcase == "past_date_time"
        past_date_time(data)
      elsif data["type"].downcase == "between_date_time"
        between_date_time(data)
      else
        @value = "INVALID DATE TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.future_date(data)
      if !data["properties"].nil? && !data["properties"]["future"].nil?
        @past = 0
        @future = data["properties"]["future"].to_i
        return get_random_date(@future, @past)
      else
        return "INVALID PARAMETER"
      end
    end

    def self.past_date(data)
      if !data["properties"].nil? && !data["properties"]["past"].nil?
        @past = data["properties"]["past"].to_i
        @future = 0
        return get_random_date(@future, @past)
      else
        return "INVALID PARAMETER"
      end
    end

    def self.between_date(data)
      if !data["properties"].nil? && !data["properties"]["from"].nil? && !data["properties"]["to"].nil?
        @to = data["properties"]["to"].to_i
        @from = data["properties"]["from"].to_i
        return get_random_date(@to, @from)
      else
        return "INVALID PARAMETER"
      end
    end

    def self.future_date_time(data)
      if !data["properties"].nil? && !data["properties"]["future"].nil?
        @past = 0
        @future = data["properties"]["future"].to_i
        return get_random_date_time(@future, @past)
      else
        return "INVALID PARAMETER"
      end
    end

    def self.past_date_time(data)
      if !data["properties"].nil? && !data["properties"]["past"].nil?
        @past = data["properties"]["past"].to_i
        @future = 0
        return get_random_date_time(@future, @past)
      else
        return "INVALID PARAMETER"
      end
    end

    def self.between_date_time(data)
      if !data["properties"].nil? && !data["properties"]["from"].nil? && !data["properties"]["to"].nil?
        @from = data["properties"]["to"].to_i
        @to = data["properties"]["from"].to_i
        return get_random_date_time(@from, @to)
      else
        return "INVALID PARAMETER"
      end
    end

    def self.get_random_date(from, to)
      @to = (Date.today - to).to_time
      @from = (Date.today - from).to_time
      return Time.at((@to.to_f - @from.to_f)*rand + @to.to_f).to_date.to_s
    end

    def self.get_random_date_time(from, to)
      @to = (Date.today - to).to_time
      @from = (Date.today - from).to_time
      return Time.at((@to.to_f - @from.to_f)*rand + @to.to_f).to_s
    end

  end
end;  end; end
