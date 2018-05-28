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
      letter_change_index = Enum.find()

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

  def split_into_sections(input) do
    split_input =
      input
      |> String.split("", trim: true)

    result = split_input
    |> Enum.with_index()
    |> Enum.reduce("", fn el, acc ->
      {letter, index} = el

      # create a new list
      target_list = Enum.slice(split_input, index..-1)

      # take_while
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
end
