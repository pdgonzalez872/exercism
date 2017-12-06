# ```
# "AABCCCDEEEE"  ->  "2AB3CD4E"  ->  "AABCCCDEEEE"
# ```

class RunLengthEncoding
  def self.encode(input)
    return "" if input.empty?

    outer_result = ""
    outer_counter = 1
    split_input = input.split("")

    split_input.each_with_index do |char, index|
      if char == split_input[index + 1]
        outer_counter += 1
        next
      else
        if outer_counter == 1
          outer_result << "#{char}"
        else
          outer_result << "#{outer_counter}#{char}"
        end
        outer_counter = 1
      end
    end
    outer_result
  end

  def self.decode(input)
    return "" if input.empty?

    outer_result = ""
    digit_counter = ""
    split_input = input.split("")

    split_input.each_with_index do |char, i|
      if char.to_i > 0
        digit_counter << char
        next
      else
        if digit_counter.empty?
          outer_result << char
        else
          outer_result << char * digit_counter.to_i
        end
        digit_counter = ""
      end
    end

    outer_result
  end
end

class BookKeeping; VERSION=3; end
