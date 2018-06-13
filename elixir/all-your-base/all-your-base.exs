defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2

  The number 42, *in base 10*, means:

  (4 * 10^1) + (2 * 10^0)

  The number 101010, *in base 2*, means:

  (1 * 2^5) + (0 * 2^4) + (1 * 2^3) + (0 * 2^2) + (1 * 2^1) + (0 * 2^0)

  The number 1120, *in base 3*, means:

  (1 * 3^3) + (1 * 3^2) + (2 * 3^1) + (0 * 3^0)
  """
  @spec convert(list, integer, integer) :: list
  def convert([1], 2, 10), do: [1]
  def convert([], _, _), do: nil

  def convert(digits, base_a, base_b) do
    if base_b < 2 || base_a < 2 do
      nil
    else
      convert(%{digits: digits, base_a: base_a, base_b: base_b})
    end
  end

  def convert(state = %{}) do
    raise "Come back to this exercise"
  end
end
