require 'pry'

class Year
  def self.leap?(year)
    LeapRules.new(year).satisfied?
  end
end

class LeapRules

  attr_reader :year

  def initialize(year)
    @year = year
  end

  def satisfied?
    return false if !year_is_divisible_by_4?

    if year_is_divisible_by_100?
      return true if year_is_divisible_by_400?
      return false
    end
    true
  end

  def year_is_divisible_by_4?
    year % 4 == 0
  end

  def year_is_divisible_by_100?
    year % 100 == 0
  end

  def year_is_divisible_by_400?
    year % 400 == 0
  end
end

class BookKeeping
  VERSION = 3
end
