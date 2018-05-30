defmodule SumOfMultiples do

  def to(1, _), do: 0
  def to(_, []), do: 0

  def to(end_range, divisible_by) do
    divisible_by
    |> Enum.map(fn factor ->
      Enum.map(1..end_range, fn n ->
        target = factor * n
         if target < end_range do
           target
         else
           0
         end
      end)
    end)
    |> List.flatten()
    |> Enum.uniq()
    |> Enum.reduce(0, fn e, acc -> acc + e end)
  end
end
