require 'pry'

class Prime
  def self.nth(value)
    raise ArgumentError if value == 0

    counter = 0
    primes = []

    while primes.size != value + 1
      primes << counter if PrimeNumberRules.new(counter).satisfied?
      counter += 1
    end

    primes.last
  end
end

# Re-using the same code as I used in Sieve.
# Added the `optimized_target_number`
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
    (FIRST_PRIME_AFTER_TWO..optimized_target_number).each do |n|
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

  # This brought it down from 36 seconds to 0.5 sec
  def optimized_target_number
    Math.sqrt(target_number) + 1
  end
end

module BookKeeping
  VERSION = 1
end

