defmodule Sublist do

  def compare([], []), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist

  def compare(a, b) do
    cond do
      a == b ->
        :equal

      b_is_not_contained_in_a?(a, b)->
        :unequal
      
      a_is_superlist_of_b?(a, b) ->
        :superlist
        
      true ->
        :sublist
    end
  end

  def a_is_superlist_of_b?(a, b) do
    target_diff = length(a) - length(b)
    length(a -- b) == target_diff
  end

  def b_is_not_contained_in_a?(a, b) do
    Enum.count(b) == Enum.count(b -- a)
  end
end
