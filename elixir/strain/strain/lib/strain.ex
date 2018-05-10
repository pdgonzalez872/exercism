defmodule Strain do
  @moduledoc """
  Implements keep and discard operations on Enumerables.
  """
  def keep([], _), do: []

  def keep(list, fun) do
    Enum.filter(list, fn e -> fun.(e) end)
  end

  def discard([], _), do: []

  def discard(list, fun) do
    list -- keep(list, fun)
  end
end
