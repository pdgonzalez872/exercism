defmodule RunLengthEncoder do

  def encode(input) do
    input
    |> classify_input()
    |> handle_input()
  end

  def handle_input({input, :no_digits}), do: input
  def handle_input({input, :empty}), do: input
  def handle_input({input, :not_handled}), do: raise "This condition has not been handled yet."

  def handle_input({input, :decode}), do: input

  def classify_input(input) do

    result =
      cond do
        !has_digits?(input) ->
          :no_digits

        input == "" ->
          :empty

        has_digits?(input) ->
          :decode

        true ->
          :not_handled
      end

    {input, result}
  end

  defp has_digits?(input) do
    !Regex.match?(~r/\d/, input)
  end
end
