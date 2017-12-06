class Bob

  QUESTION_MARK_RESPONSE = "Sure."
  PERIOD_RESPONSE = "Whatever."
  EXCLAMATION_RESPONSE = "Whoa, chill out!"
  SILENCE_RESPONSE = "Fine. Be that way!"

  def self.hey(remark)
    last_character_strategy(remark)
  end

  def self.last_character_strategy(remark)
    remark = remove_punctuation(remark)

    return SILENCE_RESPONSE if silence?(remark)

    last_character = remark[-1]

    remark_without_last_character = remark_without_last_character(remark)

    if all_caps?(remark_without_last_character)
      if all_digits?(remark_without_last_character)
        if last_character == "?"
          return QUESTION_MARK_RESPONSE
        end
        return PERIOD_RESPONSE
      end

      if all_punctuation?(remark_without_last_character) && last_character == "?"
        return QUESTION_MARK_RESPONSE
      end
      return EXCLAMATION_RESPONSE
    end

    if last_character == "?"
      return EXCLAMATION_RESPONSE if all_caps?(remark_without_last_character)
      return QUESTION_MARK_RESPONSE
    elsif last_character == "."
      return PERIOD_RESPONSE
    elsif last_character == "!"
      return PERIOD_RESPONSE if !all_caps?(remark_without_last_character)
      return EXCLAMATION_RESPONSE
    else
      return PERIOD_RESPONSE
    end
  end

  def self.remark_without_last_character(remark)
    remark_without_last_character = remark[0..-2]
  end

  def self.all_caps?(remark)
    remark == remark.upcase
  end

  def self.all_digits?(remark)
    remark.scan(/\D/).empty?
  end

  def self.all_punctuation?(remark)
    !remark.chars.any? { |char| ("a".."z").include?(char.downcase) }
  end

  def self.remove_punctuation(remark)
    remark.gsub(",", '')
          .gsub(" ", "")
          .gsub("\t", "")
          .gsub("\n", "")
          .gsub("\r", "")
          .gsub(/\s+/, "")
  end

  def self.silence?(remark)
    return true if remark.empty?
  end
end

module BookKeeping; VERSION = 1; end
