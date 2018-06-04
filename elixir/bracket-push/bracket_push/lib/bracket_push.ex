defmodule BracketPush do

  def check_brackets([]), do: false

  def check_brackets(input) do
    cleaned_input =
      input
      |> remove_whitespace()
      |> remove_pairs()
      |> select_valid_delimiters()

    case cleaned_input do
      "" ->
        true

      "[]" ->
        true

      "()" ->
        true

      "{}" ->
        true

      _ ->
        {_first, _last, net_input} =
          cleaned_input
          |> String.split("", trim: true)
          |> extract_data_from_input()
        check_brackets(net_input)
    end
  end

  def extract_data_from_input(input) do
    first = Enum.at(input, 0)
    last = Enum.at(input, -1)

    net_input =
      input
      |> List.delete_at(0)
      |> List.delete_at(-1)

    {first, last, net_input}
  end

  def remove_whitespace(input) when is_binary(input) do
    input
    |> String.replace(" ", "")
  end

  def remove_whitespace(input) when is_list(input) do
    if Enum.count(input) == 0 do
      input
    else
      input
      |> Enum.join("")
      |> String.replace(" ", "")
    end
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
    Regex.replace(r,input, "")
  end
end
