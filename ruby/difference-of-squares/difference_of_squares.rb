class Squares

  attr_reader :n

  def initialize(n)
    @n = n
  end

  def square_of_sum
    sum * sum
  end

  def sum_of_squares
    @sum_of_squares ||= (1..n).map {|i| i * i}.inject(0) {|acc, i| acc + i}
  end

  def difference
    (sum_of_squares - square_of_sum).abs
  end

  def sum
    @sum ||= (1..n).inject(0) {|acc, i| acc + i}
  end
end

module BookKeeping
  VERSION = 4
end
