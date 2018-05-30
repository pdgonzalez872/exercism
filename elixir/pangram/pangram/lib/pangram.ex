defmodule Pangram do

  def pangram?(""), do: false

  def pangram?(sentence) do
    alphabet_list = create_alphabet_list()

    result =
      sentence
      |> String.downcase()
      |> String.split("", trim: true)
      |> Enum.filter(fn e -> Enum.member?(alphabet_list, e) end)
      |> Enum.reduce(%{}, fn letter, acc ->
        if Enum.member?(Map.keys(acc), letter) do
          count = acc["#{letter}"]
          Map.put(acc, "#{letter}", count + 1)
        else
          Map.put(acc, "#{letter}", 1)
        end
      end)

    alphabet_list == Map.keys result
  end

  # http://elixir-recipes.github.io/strings/list-with-alphabet/
  def create_alphabet_list() do
    for n <- ?a..?z, do: << n :: utf8 >>
  end
end
