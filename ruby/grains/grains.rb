class Grains

  FLOOR                           = 1
  CEILING                         = 64
  VALUE_TO_MULTIPLY_BY            = 2

  def self.square(n)
    raise ArgumentError if n < FLOOR || n > CEILING
    result = build_board_matrix(n)
    result[n]
  end

  def self.build_board_matrix(n)
    result = Hash.new(VALUE_TO_MULTIPLY_BY)
    result[1] = 1

    (2..n).each do |i|
      target = result.values.last
      result[i] = target * VALUE_TO_MULTIPLY_BY
    end
    result
  end

  def self.total
    result = build_board_matrix(CEILING)
    total_sum = result.inject(0) do |acc, (key, value)|
      acc += value
    end
  end
end

class BookKeeping; VERSION = 1; end
