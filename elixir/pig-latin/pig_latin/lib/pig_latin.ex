defmodule PigLatin do

  @ending(["ay"])

  def translate(word) do
    word
    |> handle_one_word()
  end

  def handle_one_word(word) do
    word
    |> String.split("")
    |> Enum.filter(&(&1 != ""))
    |> handle_ending()
  end

  def determine_case(split_word) do
    [head | tail] = split_word
    second_letter = extract_second_letter(tail)

    cond do
      is_vowel(head) ->
        :vowel

      !is_vowel(head) && is_vowel(second_letter) ->

        case String.to_atom("#{head}#{second_letter}") do
          :qu ->
            :qu

          _ ->
            :one_consonant
        end


      true ->
        :two_or_more_consonants
    end
  end

  def handle_ending(split_word) do
    [head | tail] = split_word

    result = determine_case(split_word)

    handle_call(result, split_word) ++ @ending
    |> Enum.join("")
  end


  def handle_call(:vowel, letter_list) do
    [head | tail] = letter_list
  end

  def handle_call(:one_consonant, letter_list) do
    [head | tail] = letter_list
    tail ++ [head]
  end

  def handle_call(:two_or_more_consonants, letter_list) do

    # qu

    first_vowel_index = Enum.find_index(letter_list, fn(w)-> is_vowel(w) end)
    consonants = Enum.slice(letter_list, 0..(first_vowel_index - 1))
    rest = Enum.slice(letter_list, first_vowel_index..-1)

    rest ++ consonants
  end

  def handle_call(:qu, letter_list) do
    move_first_and_second_letters_to_end(letter_list)
  end



  def move_first_and_second_letters_to_end(letter_list) do
    [first, second | tail] = letter_list
    tail ++ [first, second]
  end

  def handle_call(:sch, letter_list) do

  end

  def is_vowel(letter) do
    ["a", "e", "i", "o", "u"]
    |> Enum.member?(letter)
  end

  def extract_second_letter(list) do
    [second_letter | rest_without_second_letter] = list
    second_letter
  end
end
