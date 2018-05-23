defmodule Acronym do

  @module_doc ~S"""
  Nice! This challenge, coupled with a comment from an earlier exercise helped
  me stop a pattern I found annoying (noted in an exercise before):

  This pattern:

  input
  |> String.split("")
  |> Enum.filter(fn(el)-> el != "" end)

  Can be this:
  input
  |> String.split("", trim: true)

  Awesome!
  """

  def abbreviate(input) when is_binary(input) do
    input
    |> handle_punctuation()
    |> split_sentence_by_spaces()
    |> take_first_letters_from_each_element() # Enum.map -> fun
    |> combine_first_letters()
  end

  def handle_punctuation(input) do
    input
    |> String.replace("-", " ")
  end

  def split_sentence_by_spaces(input), do:  String.split(input, " ")

  def take_first_letters_from_each_element(input) do
    input
    |> Enum.map(fn(el)->
      take_first_letter_from_element(el)
    end)
  end

  def take_first_letter_from_element(word) do
    cond do
      has_inconsistent_case?(word) ->
        # find first upper, split there, send to take_first_letters_from_each_element()
        split_word = String.split(word, "", trim: true)
        [first | rest] = split_word

        second_uppercase_letter_index = Enum.find_index(rest, fn(el)-> el == String.upcase(el) end)

        Enum.slice(rest, second_uppercase_letter_index, Enum.count(rest))
        |> Enum.join("")
        |> take_first_letter_from_element()

      true ->
        [[first]] = Regex.scan(~r/^./, word)
        String.upcase(first)
    end
  end

  @doc """
  The assumption here is that words only have 1 uppercase letter.
  If 2, it is inconsistent. If none, consistent as well.

  Examples:

  iex> Acronym.has_inconsistent_case?("Paulo")
  false

  iex> Acronym.has_inconsistent_case?("paulo")
  false

  iex> Acronym.has_inconsistent_case?("PauLo")
  true
  """
  def has_inconsistent_case?(input) do
    count_of_upper =
      input
      |> String.split("", trim: true)
      |> Enum.reduce(0, fn(el, acc)->
        if el == String.upcase(el) do
          acc = acc + 1
        end
        acc # unsafe var here, cool, let's fix this later.
      end)

    if count_of_upper > 1 do
      true
    else
      false
    end
  end

  def combine_first_letters(input), do: Enum.join(input, "")

end
