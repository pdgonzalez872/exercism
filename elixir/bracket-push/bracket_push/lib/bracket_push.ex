defmodule BracketPush do
  def check_brackets([]), do: false

  def check_brackets(input) do
    processed_input =
      input
      |> remove_whitespace()
      |> remove_pairs()
      |> select_valid_delimiters()

    case processed_input do
      "" ->
        true

      "[]" ->
        true

      "()" ->
        true

      "{}" ->
        true

      _ ->
        processed_input
        |> String.split("", trim: true)
        |> extract_data_from_input()
        |> check_brackets()
    end
  end

  def extract_data_from_input(input) do
    input
    |> List.delete_at(0)
    |> List.delete_at(-1)
  end

  def remove_whitespace(input) when is_binary(input) do
    input
    |> String.replace(" ", "")
  end

  def remove_whitespace([]), do: []

  def remove_whitespace(input) when is_list(input) do
    input
    |> Enum.join("")
    |> String.replace(" ", "")
  end

  def remove_pairs(""), do: ""

  def remove_pairs(input) do
    input
    |> String.replace("[]", "")
    |> String.replace("{}", "")
    |> String.replace("()", "")
  end

  def select_valid_delimiters(input) do
    r = ~r/[\s\d\-\+\.\&\\^*\/a-z]+/
    Regex.replace(r, input, "")
  end
end
