module Raindrops

  FACTOR_MATRIX = {"3" => "Pling", "5" => "Plang", "7" => "Plong"}

  FACTOR_MATRIX.each do |k, v|
    define_singleton_method "factor_of_#{k}".to_sym do |message|
      message % k.to_i == 0
    end
  end

  def self.convert(n)
    result = ""
    result << "Pling" if factor_of_3(n)
    result << "Plang" if factor_of_5(n)
    result << "Plong" if factor_of_7(n)
    return n.to_s if result == ""
    result
  end
end

module BookKeeping
  VERSION = 3
end
