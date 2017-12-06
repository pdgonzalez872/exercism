require 'pry'

class SumOfMultiples

  # If we list all the natural numbers up to but not including 20 that are
  # multiples of either 3 or 5, we get 3, 5, 6 and 9, 10, 12, 15, and 18.
  def self.calculate_sum_of_multiples(ceiling, target_number)
    (target_number...ceiling).select do |i|
      i % target_number == 0
    end
  end

  attr_reader :a, :b, :c

  def initialize(*args)
    case args.size
    when 0
      return
    when 1
      @a = args[0]
    when 2
      @a, @b = args
    when 3
      @a, @b, @c = args
    end
  end

  def to(ceiling)
    return 0 if @a.nil?
    return 0 if ceiling < a

    result = []

    if a
      multiples_a = self.class.calculate_sum_of_multiples(ceiling, a)
      result = multiples_a
    end

    if a && b
      multiples_b = self.class.calculate_sum_of_multiples(ceiling, b)
      result = multiples_a + multiples_b
    end

    if a && b && c
      multiples_c = self.class.calculate_sum_of_multiples(ceiling, c)
      result = multiples_a + multiples_b + multiples_c
    end
    result.uniq.inject(0) {|acc, i| acc+= i}
  end
end

module BookKeeping; VERSION = 2; end
