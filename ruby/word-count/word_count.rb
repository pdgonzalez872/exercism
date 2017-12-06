class Phrase

  PUNCTUATION    = "!!&@$%^:."
  SHORTENED_WORD = "n't"

  attr_reader :sentence, :words

  def initialize(sentence)
    @sentence = sentence
    @words = self.class.parse_sentence(sentence)
  end

  def word_count
    Hash.new(0).tap do |result|
      words.each {|w| result[w] += 1}
    end
  end

  def self.deal_with_shortened_words(word)
    word.include?(SHORTENED_WORD) ? word : word.gsub("'", "")
  end

  def self.parse_sentence(sentence)
    PUNCTUATION.split("").each do |pun|
      sentence = sentence.gsub(pun, "")
    end
    sentence.gsub(",", " ").split(" ").map {|w| w.downcase}.map {|w| deal_with_shortened_words(w)}
  end
end

class BookKeeping; VERSION=1; end
