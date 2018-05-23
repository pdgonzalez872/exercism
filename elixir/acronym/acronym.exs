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

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"

  iex> Acronym.abbreviate("This is a string")
  "TIAS"

  iex> Acronym.abbreviate("HyperText Markup Language")
  "HTML"

  # WhatAboutMorethanJustTwoUpperCaseletters
  iex> Acronym.abbreviate("WhatAboutMorethanJustTwoUpperCaseletters Acronym")
  "WAMJTUCA"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(input) when is_binary(input) do
    input
    |> handle_punctuation()
    |> split_sentence_by_spaces()
    |> Enum.map(fn el -> take_first_letter_from_element(el) end)
    |> combine_first_letters()
  end

  def handle_punctuation(input) do
    input
    |> String.replace("-", " ")
  end

  def split_sentence_by_spaces(input), do: String.split(input, " ")

  def take_first_letter_from_element(word) do
    cond do
      has_inconsistent_case?(word) ->
        split_word = String.split(word, "", trim: true)
        [_ | rest] = split_word

        second_uppercase_letter_index =
          Enum.find_index(rest, fn el -> el == String.upcase(el) end)

        second =
          Enum.slice(rest, second_uppercase_letter_index, Enum.count(rest))
          |> Enum.join("")
          |> take_first_letter_from_element()

        first_word =
          split_word
          |> Enum.slice(0, second_uppercase_letter_index - 1)
          |> Enum.join()

        take_first_letter_from_element(first_word) <> second

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
      |> Enum.reduce(0, fn el, acc ->
        if el == String.upcase(el) do
          acc + 1
        else
          acc
        end
      end)

    if count_of_upper > 1 do
      true
    else
      false
    end
  end

  def combine_first_letters(input), do: Enum.join(input, "")
end
