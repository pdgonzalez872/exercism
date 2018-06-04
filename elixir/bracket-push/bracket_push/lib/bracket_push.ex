defmodule BracketPush do


  # def check_brackets([]), do: false
  # def check_brackets(""), do: true
  # def check_brackets("[]"), do: true

  def check_brackets(input) do

    case input do
      "" ->
        true

      "[]" ->
        true

      [] ->
        false

      _ ->
        {first, last, net_input} =
          split_input =
            input
            |> String.split("", trim: true)
            |> extract_data_from_input()

        check_brackets(net_input)
    end
  end

  def extract_data_from_input(input) do
    first = hd(input)
    [last] = tl(input)

    net_input = (input -- [first]) -- (input -- [last])

    {first, last, net_input}
  end
end
