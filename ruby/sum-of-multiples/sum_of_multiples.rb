require 'pry'

class SumOfMultiples

  # If we list all the natural numbers up to but not including 20 that are
  # multiples of either 3 or 5, we get 3, 5, 6 and 9, 10, 12, 15, and 18.
  def self.calculate_sum_of_multiples(ceiling, target_number)
    (target_number...ceiling).select do |i|
      i % target_number == 0
    end
  end

  attr_reader :factors

  def initialize(*args)
    @factors = args
  end

  def to(ceiling)
    return 0 if factors.empty?
    factors.map do |f|
      self.class.calculate_sum_of_multiples(ceiling, f)
    end.flatten.uniq.inject(0) {|acc, i| acc+= i}
  end
end

module BookKeeping; VERSION = 2; end
