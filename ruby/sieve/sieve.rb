class PrimeNumberRules

  FIRST_PRIME_AFTER_TWO = 3

  def self.target_number_is_one(n)
    n == 1
  end

  attr_reader :target_number

  def initialize(target_number)
    @target_number = target_number
  end

  def satisfied?
    return true if target_number_is_one || target_number_is_two

    # Even numbers are not prime
    return false if target_number_is_divisible_by_two

    # prime numbers can only be divided by 1 and self.
    (FIRST_PRIME_AFTER_TWO..target_number - 1).each do |n|
      if target_number % n == 0
        return false
      else
        # nothing
      end
    end

    true
  end

  def target_number_is_one
    target_number == 1
  end

  def target_number_is_two
    target_number == 2
  end

  def target_number_is_divisible_by_two
    target_number % 2 == 0
  end
end

class Sieve

  attr_reader :target_number

  def initialize(target_number)
    @target_number = target_number
  end

  def primes
    result = []
    return result if PrimeNumberRules.target_number_is_one(target_number)

    (2..target_number).each do |n|
      if PrimeNumberRules.new(n).satisfied?
        result << n
      else
        # nothing
      end
    end

    result
  end
end

module BookKeeping
  VERSION = 1
end
