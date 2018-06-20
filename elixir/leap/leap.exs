defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    by_4 = divisible_by(year, 4)
    by_100 = divisible_by(year, 100)
    by_400 = divisible_by(year, 400)
    valid?(by_4, by_100, by_400)

  end

  def divisible_by(year, int) do
    rem(year, int) == 0
  end

  def valid?(true, false, false), do: true
  def valid?(true, false, true), do: true
  def valid?(true, true, true), do: true

  def valid?(_, _, _), do: false
end
