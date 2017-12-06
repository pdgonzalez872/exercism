class Hamming
  class << self
    def compute(a, b)
      validate_inputs(a, b)
      split_a, split_b = split_strings(a, b)
      return calculate_distance(split_a, split_b)
    end

    private

    def calculate_distance(a, b)
      sum = 0
      a.each_with_index do |el, i|
        sum += 1 if !strings_are_identical(el, b[i])
      end
      sum
    end

    def validate_inputs(a, b)
      raise ArgumentError unless lenghts_are_equal(a, b)
    end

    def lenghts_are_equal(a, b)
      a.length == b.length
    end

    def parse_strings(a, b)
      return a.split(''), b.split('')
    end

    def strings_are_identical(a, b)
      a == b
    end

    def split_strings(a, b)
      return a.split(''), b.split('')
    end
  end
end

module BookKeeping
  VERSION = 3
end
