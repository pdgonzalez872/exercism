defmodule Roman do
  @roman_numerals_mapping(
    %{
      1000 => "M",
      900 => "CM",
      500 => "D",
      400 => "CD",
      100 => "C",
      90 => "XC",
      50 => "L",
      40 => "XL",
      10 => "X",
      9 => "IX",
      5 => "V",
      4 => "IV",
      1 => "I"
    }
  )

  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t()
  def numerals(number) do
    calculate_roman_numeral(%{input: number, output: []})
  end

  def calculate_roman_numeral(state = %{input: 0}) do
    state.output
    |> Enum.join("")
  end

  def calculate_roman_numeral(state = %{}) do
    result = @roman_numerals_mapping
    |> Enum.reverse()
    |> Enum.find(fn {int, _roman} ->
      state.input >= int
    end)

    {int, roman} = result

    state
    |> Map.put(:output, state.output ++ [roman])
    |> Map.put(:input, state.input - int)
    |> calculate_roman_numeral()
  end
end
