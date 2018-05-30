defmodule SumOfMultiples do

  def to(1, _), do: 0
  def to(_, []), do: 0

# If we list all the natural numbers below 20 that are multiples of 3 or 5,
# we get 3, 5, 6, 9, 10, 12, 15, and 18.
# The sum of these multiples is 78.


  def to(end_range, divisible_by) do

    result =
    divisible_by
    |> Enum.map(fn factor ->
      targets = Enum.map(1..end_range, fn n ->
        target = factor * n
         if target < end_range do
           target
         else
           0
         end
      end)
    end)

    require IEx; IEx.pry

    Enum.reduce(result, 0, fn e, acc -> acc + e end)

    # Unique numbers only

  end
end
