defmodule BracketPush do

  def check_brackets([]), do: false

  def check_brackets(input) do
    cleaned_input =
      input
      |> clean_input()
      |> remove_pairs()
      |> filter_symbols()

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
        {first, last, net_input} =
          split_input =
            cleaned_input
            |> String.split("", trim: true)
            |> extract_data_from_input()
        check_brackets(net_input)
    end
  end

  def shim(input) do
    require IEx; IEx.pry
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

  def clean_input(input) when is_binary(input) do
    input
    |> String.replace(" ", "")
  end

  def clean_input(input) when is_list(input) do
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

  def filter_symbols(input) do
    r = ~r/[\s\d\-\+\.\&\\^*\/a-z]+/
    Regex.replace(r,input, "")
  end
end
