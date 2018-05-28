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
    input
    |> String.split("", trim: true)
    |> create_data_structure()
    |> combine_data_structure()
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
end
