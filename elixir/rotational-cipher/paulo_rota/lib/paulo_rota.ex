defmodule PauloRota do
  @moduledoc """
  Documentation for PauloRota.
  """

  def create_data_for_letter(letter) do

    # Nice list comprehension pattern, source:
    # http://elixir-recipes.github.io/strings/list-with-alphabet/
    lowercase = for n <- ?a..?z, do: << n :: utf8 >>
    uppercase = for n <- ?A..?Z, do: << n :: utf8 >>
    lowercase_minus_a = for n <- ?b..?z, do: << n :: utf8 >>
    uppercase_minus_A = for n <- ?B..?Z, do: << n :: utf8 >>

    result = %{letter: letter}

    list =
      cond do
        letter == "a" ->
          translate_utf_list(?a..?z)

        letter == "z" ->
          translate_utf_list(?z..?a)

        letter == "A" ->
          translate_utf_list(?A..?Z)

        letter == "Z" ->
          translate_utf_list(?Z..?A)

        Enum.member?(lowercase_minus_a, letter) ->
          create_alphabet_list(lowercase, letter)

        Enum.member?(uppercase_minus_A, letter) ->
          create_alphabet_list(uppercase, letter)

        # letter == "B" ->
        #   raise "upper"

        true ->
          raise "Should not have gotten here..."
      end
    Map.put(result, :list, list)
  end

  def translate_utf_list(range) do
    Enum.map(range, fn(el) -> << el :: utf8 >> end)
  end

  def create_alphabet_list(original_list, letter) do
    start_index = Enum.find_index(original_list, fn el -> el == letter end)
    tail = Enum.slice(original_list, start_index, length(original_list))
    head = Enum.slice(original_list, 0, start_index)

    tail ++ head
  end
end
