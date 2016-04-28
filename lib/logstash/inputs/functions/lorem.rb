# encoding: utf-8
require 'faker'

module LogStash; module Inputs; class Functions;
  class Lorem

    def self.parse(data)
      if data["type"].downcase == "word"
        word(data)
      elsif data["type"].downcase == "characters"
        characters(data)
      elsif data["type"].downcase == "sentence"
        sentence(data)
      elsif data["type"].downcase == "sentences"
        sentences(data)
      elsif data["type"].downcase == "paragraph"
        paragraph(data)
      elsif data["type"].downcase == "paragraphs"
        paragraphs(data)
      else
        @value = "INVALID LOREM TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.word(data)
      # This could be cleaner with a set number else 1, would remove if statement
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @number = data["properties"]["number"]
        Faker::Lorem.words(@number)
      else
        return Faker::Lorem.word
      end
    end

    def self.characters(data)
      if !data["properties"].nil? && !data["properties"]["count"].nil?
        @count = data["properties"]["count"]
        return Faker::Lorem.characters(@count)
      else
        return Faker::Lorem.characters
      end
    end

    def self.sentence(data)
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @count = data["properties"]["number"]
        return Faker::Lorem.sentence(@count)
      else
        return Faker::Lorem.sentence
      end
    end

    def self.sentences(data)
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @count = data["properties"]["number"]
        return Faker::Lorem.sentences(@count)
      else
        return Faker::Lorem.sentences
      end
    end

    def self.paragraph(data)
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @count = data["properties"]["number"]
        return Faker::Lorem.paragraph(@count)
      else
        return Faker::Lorem.paragraph
      end
    end

    def self.paragraphs(data)
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @count = data["properties"]["number"]
        return Faker::Lorem.paragraphs(@count)
      else
        return Faker::Lorem.paragraphs
      end
    end

  end
end;  end; end
