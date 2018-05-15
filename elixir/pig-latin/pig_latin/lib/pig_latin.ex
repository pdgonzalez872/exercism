defmodule PigLatin do

  @ending(["ay"])

  @outliers_and_their_index(%{
      qu: 2, # really is the length of the outlier
      squ: 3,
    })

  def translate(word) do
    if String.contains?(word, " ") do
      word
      |> handle_sentence()

    else
      word
      |> handle_one_word()

    end
  end

  def handle_one_word(word) do
    word
    |> String.split("")
    |> Enum.filter(&(&1 != ""))
    |> handle_ending()
  end

  def handle_sentence(sentence) do
    sentence
    |> String.split(" ")
    |> Enum.map(fn(w) -> handle_one_word(w) end)
    |> Enum.join(" ")
  end

  def determine_case(split_word) do
    [a, b, c | _] = split_word

    cond do
      is_vowel(a) ->
        :vowel

      !is_vowel(a) && is_vowel(b) ->

        case String.to_atom("#{a}#{b}") do
          :qu ->
            :qu

          _ ->
            :one_consonant
        end

      x_and_y_rule(a, b) ->
        :vowel

      true ->
        case String.to_atom("#{a}#{b}#{c}") do
          :squ ->
            :squ
          _ ->
            :two_or_more_consonants
        end
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
    first_vowel_index = Enum.find_index(letter_list, fn(w)-> is_vowel(w) end)
    consonants = Enum.slice(letter_list, 0..(first_vowel_index - 1))
    rest = Enum.slice(letter_list, first_vowel_index..-1)

    rest ++ consonants
  end

  def handle_call(outlier_rule, letter_list) do
    {:ok, index} = Map.fetch(@outliers_and_their_index, outlier_rule)

    letter_list
    |> move_letters_based_on_index(index)
  end

  def move_letters_based_on_index(letter_list, index) do
    consonants = Enum.slice(letter_list, 0..(index - 1))
    rest = Enum.slice(letter_list, index..-1)

    rest ++ consonants
  end

  def move_first_and_second_letters_to_end(letter_list) do
    [first, second | tail] = letter_list
    tail ++ [first, second]
  end

  def is_vowel(letter) do
    ["a", "e", "i", "o", "u"]
    |> Enum.member?(letter)
  end

  def x_and_y_rule(a, b) do
    a in ["x", "y"] && !is_vowel(b)
  end
end
