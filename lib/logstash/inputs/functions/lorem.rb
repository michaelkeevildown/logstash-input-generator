# encoding: utf-8
require 'faker'

module LogStash; module Inputs; class Functions;
  class Lorem

    def self.parse(data)
      if data["type"].downcase == "word"
        gen_word(data)
      elsif data["type"].downcase == "characters"
        gen_characters(data)
      elsif data["type"].downcase == "sentence"
        gen_sentence(data)
      elsif data["type"].downcase == "sentences"
        gen_sentences(data)
      elsif data["type"].downcase == "paragraph"
        gen_paragraph(data)
      elsif data["type"].downcase == "paragraphs"
        gen_paragraphs(data)
      else
        @value = "INVALID LOREM TYPE"
      end
    end

    ############################
    ## custom functions below ##
    ############################
    def self.gen_word(data)
      # This could be cleaner with a set number else 1, would remove if statement
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @number = data["properties"]["number"]
        Faker::Lorem.words(@number)
      else
        return Faker::Lorem.word
      end
    end

    def self.gen_characters(data)
      if !data["properties"].nil? && !data["properties"]["count"].nil?
        @count = data["properties"]["count"]
        return Faker::Lorem.characters(@count)
      else
        return Faker::Lorem.characters
      end
    end

    def self.gen_sentence(data)
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @count = data["properties"]["number"]
        return Faker::Lorem.sentence(@count)
      else
        return Faker::Lorem.sentence
      end
    end

    def self.gen_sentences(data)
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @count = data["properties"]["number"]
        return Faker::Lorem.sentences(@count)
      else
        return Faker::Lorem.sentences
      end
    end

    def self.gen_paragraph(data)
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @count = data["properties"]["number"]
        return Faker::Lorem.paragraph(@count)
      else
        return Faker::Lorem.paragraph
      end
    end

    def self.gen_paragraphs(data)
      if !data["properties"].nil? && !data["properties"]["number"].nil?
        @count = data["properties"]["number"]
        return Faker::Lorem.paragraphs(@count)
      else
        return Faker::Lorem.paragraphs
      end
    end

  end
end;  end; end
