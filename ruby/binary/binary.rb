class Binary
  def self.to_decimal(string)
    return 0 if string == "0"
    return 1 if string == "1"

    split_string = string.split("")

    raise ArgumentError unless input_is_valid?(split_string)

    split_string.reverse.each_with_index.map do |s, i|
      [s.to_i, i]
    end.inject(0) do |sum, i|
      sum += i[0] * (2 ** i[1])
    end
  end

  def self.input_is_valid?(split_string)
    split_string.all? do |i|
      i == "0" || i == "1"
    end
  end
end

module BookKeeping; VERSION = 3; end
