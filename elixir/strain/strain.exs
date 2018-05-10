defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep([], _), do: []

  def keep(list, fun) do
    list
    |> Enum.reduce([], fn e, acc ->
      if fun.(e) do
        [e | acc]
      else
        acc
      end
    end)
    |> Enum.reverse()
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns false.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard([], _), do: []

  def discard(list, fun) do
    list -- keep(list, fun)
  end
end
