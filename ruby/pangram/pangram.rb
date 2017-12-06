module Pangram

  ENGLISH_ALPHABET = "abcdefghijklmnopqrstuvwxyz"

  def self.pangram?(phrase)
    return false if phrase.empty?
    phrase = phrase.downcase

    pangram_hash = create_hash_from_string(ENGLISH_ALPHABET)
    phrase_hash = create_hash_from_string(phrase)

    pangram_hash.all? do |k, v|
      phrase_hash["#{k}"] >= v
    end
  end

  def self.create_hash_from_string(string)
    result = Hash.new(0)

    string.split("").each do |letter|
      result["#{letter}"] += 1
    end

    result
  end
end

module BookKeeping
  VERSION = 6
end
