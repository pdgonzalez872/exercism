defmodule Accumulate do

  def accumulate([], _), do: []

  def accumulate(col, fun) do
    col
    |> Enum.reduce([], fn(el, acc)-> acc ++ [fun.(el)] end)
  end

end
