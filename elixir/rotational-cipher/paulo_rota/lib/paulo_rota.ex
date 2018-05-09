defmodule PauloRota do
  @moduledoc """
  Documentation for PauloRota.
  """

  def create_data_for_letter(letter) do

    # Nice list comprehension pattern, source:
    # http://elixir-recipes.github.io/strings/list-with-alphabet/
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
          binaries_list = :binary.bin_to_list(letter <> <<0>>)
          start_range = Enum.at(binaries_list, 0)
          end_range = start_range - 1

          #require IEx; IEx.pry

          start_range..end_range
          |> Enum.to_list()
          |> List.to_string()

        letter == "B" ->
          raise "upper"

        true ->
          raise "nothing."
      end
    Map.put(result, :list, list)
  end

  def translate_utf_list(range) do
    Enum.map(range, fn(el) -> << el :: utf8 >> end)
  end
end
