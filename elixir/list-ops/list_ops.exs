defmodule ListOps do
  @moduledoc """
  This makes me appreciate the existing implementations in Elixir.

  All of my functions struggle with big inputs. I know they would eventually finish,
  but that's not optimal.
  """

  def count([]), do: 0

  def count([head|tail] = input) when is_list(input) do
    1 + count(tail)
  end

  def reverse([]), do: []

  # This works, but takes forever for huge lists
  # curious to see a good implementation of this.
  def reverse([head|tail] = input) when is_list(input) do
    reverse(tail) ++ [head]
  end

  def map([], _fun), do: []

  def map([head|tail], fun) do
    [fun.(head)] ++ map(tail, fun)
  end

  def filter([], _fun), do: []

  def filter([head|tail], fun) do
    if fun.(head) do
      [head] ++ filter(tail, fun)
    else
      filter(tail, fun)
    end
  end

  def reduce([], 0, _fun), do: 0
  def reduce([], acc, _fun), do: acc

  # Nice! Saw how to take 2 params here:
  # http://exercism.io/submissions/d7a9be6bc75845faba42fccd6269fea7
  def reduce([head|tail], acc, fun) do
    reduce(tail, fun.(head, acc), fun)
  end

  def append([], input), do: input
  def append(a, b), do: a ++ b

  # Not performant either...
  def concat([]), do: []
  def concat(input) do
    input
    |> reduce([], (fn e, acc -> acc ++ e end))
  end
end
