defmodule Triangle do


  def kind(a, b, c) do
    cond do
      is_a_valid_triangle?(a, b, c) ->
        "na"

      is_equilateral?(a, b, c) ->
        {:ok, :equilateral}

      true ->
        {:error}
    end
  end

  def is_equilateral?(a, b, c) do
    
    # target = a
    # Enum.all?([a, b, c], fn(el) -> el == target end)
    count = get_count(a, b, c)
    count == 3
  end

  def is_isosceles(a, b, c) do
    set = MapSet.new([a, b, c])
    Enum.count(set)
  end

  def is_a_valid_triangle?(a, b, c) do
    false
  end

  def get_count(a, b, c) do
    [a, b, c]
    |> MapSet.new()
    |> Enum.count()
  end
end
