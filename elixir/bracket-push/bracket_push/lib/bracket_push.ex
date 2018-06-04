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

        split_input =
          input
          |> String.split("", trim: true)

        {first, last, net_input} = extract_data_from_input(split_input)

        require IEx; IEx.pry

        # false
    end
    split_input =
      input
      |> String.split("", trim: true)

    {first, last, net_input} = extract_data_from_input(split_input)

    require IEx; IEx.pry
    cond do
      # even numbers input only

      check_brackets(first <> last) == false ->
        check_brackets(net_input)

      true ->
        false
    end


  end

  def extract_data_from_input(input) do
    first = hd(input)
    [last] = tl(input)

    net_input = (input -- [first]) -- (input -- [last])

    {first, last, net_input}
  end
end
