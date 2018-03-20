require "pry"

class Series

  attr_reader :input_string

  def initialize(input_string)
    @input_string = input_string.split("")
  end

  def slices(slice_size)
    a=[]

    input_string.each_with_index do |el, i|
        a << el + input_string[i+slice_size] unless input_string[i+slice_size].nil?
    end

    a


    # target = input_string
    # sliding_slice_size = slice_size

    # output = []
    # target.each_with_index do |r, i|
    #   if i + 1 == target.size
    #     output << target[-slice_size..-1]
    #   else
    #     output << target[i..sliding_slice_size]
    #     sliding_slice_size += 1
    #   end
    #   #return output if i == target.size - 1 unless slice_size == 1
    # end
    # output.flatten
  end
end
