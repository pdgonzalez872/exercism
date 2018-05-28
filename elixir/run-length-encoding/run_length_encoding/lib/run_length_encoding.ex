defmodule RunLengthEncoder do

  def encode(input) do
    input
    |> classify_input()
    |> handle_input()
  end

  def classify_input(input) do

    result =
      cond do

        input == "" ->
          :empty

        has_digits?(input) ->
          :decode

        !has_digits?(input) ->
          :encode

        true ->
          :not_handled
      end

    {input, result}
  end

  def handle_input({input, :no_digits}), do: input
  def handle_input({input, :empty}), do: input

  def handle_input({input, :not_handled}) do
    raise "This condition has not been handled yet."
  end

  def handle_input({input, :encode}) do
    split_input =
      input
      |> String.split("", trim: true)

    result = split_input
    |> Enum.with_index()
    |> Enum.reduce("", fn el, acc ->
      {letter, index} = el

      target_list = Enum.slice(split_input, index..-1)

      # find the first non current letter -> I want the index of B
      require IEx; IEx.pry

      #letter_change_index = Enum.find()

      # get the current index, minus the change of index, add that to the letter.

      repetitions = Enum.take_while(target_list, fn new_list_el ->
        letter == new_list_el
      end) |> Enum.count()

      if repetitions == 1 do
        acc <> "#{letter}"
      else
        acc <> "#{repetitions}#{letter}"
      end
    end)
  end

  defp has_digits?(input) do
    Regex.match?(~r/\d/, input)
  end

  def create_data_structure(input) do
    input
    |> Enum.reduce(%{}, fn el, acc ->
      if Map.has_key?(acc, el) do
        Map.update! acc, el, fn(e) -> e + 1 end
      else
        Map.put(acc, el, 1)
      end
    end)
  end

  def combine_data_structure(input) do
    input
    |> Enum.reduce("", fn({k, v}, acc) ->
      if v == 1 do
        acc <> "#{k}"
      else
        acc <> "#{v}#{k}"
      end
    end)
  end

  @doc ~S"""
  End result -> "WWBW" == ["WW", "B", "W"]
  Intermediate result -> ["W", "W", "B", "W"]
  recursive function that I choose where the next index is -> the first non-repetitive
  """
  def split_into_sections(input) do

    split_input =
      input
      |> String.split("", trim: true)

    result = split_input
    |> IO.inspect()
    |> Enum.with_index()
    |> Enum.map(fn el ->
      {letter, index} = el

      target_list = Enum.slice(split_input, (index)..-1)

      letter_change_index = Enum.find_index(target_list, fn e -> e != letter end)

      cond do

        # last letter
        is_nil(letter_change_index) ->
          nil

# TODO: Continue here, play with indexes so I can sort stuff

        # only one letter
        (letter_change_index - 1) == 0 ->
          %{output: letter, index: index}

        true ->
          output = Enum.slice(split_input, index..letter_change_index - 1) |> Enum.join("")
          %{output: output,
          index: index}
      end
    end)
    |> Enum.filter(fn e -> !is_nil(e) end)
  end
end
