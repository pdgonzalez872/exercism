defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0 do
    {:error, "all side lengths must be positive"}
  end

  def kind(a, b, c) do
    side_list = [a, b, c]

    cond do
      !is_a_valid_triangle?(side_list) ->
        {:error, "side lengths violate triangle inequality"}

      is_equilateral?(side_list) ->
        {:ok, :equilateral}

      is_isosceles?(side_list) ->
        {:ok, :isosceles}

      is_scalene?(side_list) ->
        {:ok, :scalene}

      true ->
        {:error}
    end
  end

  def is_equilateral?(side_list), do: get_count(side_list) == 1

  def is_isosceles?(side_list), do: get_count(side_list) == 2

  def is_scalene?(side_list), do: get_count(side_list) == 3

  def is_a_valid_triangle?(side_list) do
    [a, b, c] = side_list

    a + b > c and b + c > a and a + c > b
  end

  def get_count(side_list) do
    side_list
    |> MapSet.new()
    |> Enum.count()
  end
end
