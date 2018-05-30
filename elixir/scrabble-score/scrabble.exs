defmodule Scrabble do
  @one ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"]
  @two ["D", "G"]
  @three ["B", "C", "M", "P"]
  @four ["F", "H", "V", "W", "Y"]
  @five ["K"]
  @eight ["J", "X"]
  @ten ["Q", "Z"]

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer

  def score(""), do: 0
  def score(" \t\n"), do: 0

  def score(word) do
    word
    |> String.split("", trim: true)
    |> Enum.reduce(0, fn el, acc -> acc + letter_points(el) end)
  end

  defp letter_points(letter) do
    target_letter = String.upcase(letter)

    cond do
      Enum.member?(@one, target_letter) ->
        1

      Enum.member?(@two, target_letter) ->
        2

      Enum.member?(@three, target_letter) ->
        3

      Enum.member?(@four, target_letter) ->
        4

      Enum.member?(@five, target_letter) ->
        5

      Enum.member?(@eight, target_letter) ->
        8

      Enum.member?(@ten, target_letter) ->
        10

      true ->
        0
    end
  end
end
