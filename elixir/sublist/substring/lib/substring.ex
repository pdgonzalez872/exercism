defmodule Sublist do
  @module_doc"""
  The Regex strategy fails when dealing with floats -> 1 != 1.0
  May need to compare with lists.

  """

  def compare([], []), do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist

  def compare(a, b) do

    strat = choose_strategy(a, b)

    cond do
      equal?(a, b, strat) ->
        :equal

      superlist?(a, b, strat) ->
        :superlist
        
      sublist?(a, b, strat) ->
        :sublist

       unequal?(a, b, strat)->
        :unequal
      
      true ->
        # require IEx; IEx.pry
        raise "wooo"
    end
  end

  def choose_strategy(a, b) do
    large_list_max = 100
    if Enum.count(a) > large_list_max || Enum.count(b) > large_list_max do
      :list
    else
      :regex
    end
  end

  def superlist?(a, b, :regex) do
    {a_string, b_string} = a_b_to_string(a, b)

    {:ok, r} = Regex.compile(b_string)
    Regex.match?(r, a_string)
  end

  def superlist?(a, b, :list) do

  end

  def sublist?(a, b, :regex) do
    {a_string, b_string} = a_b_to_string(a, b)

    {:ok, r} = Regex.compile(a_string)
    Regex.match?(r, b_string)
  end

  def equal?(a, b, :regex) do
    {a_string, b_string} = a_b_to_string(a, b)
    a_string == b_string
  end

  def unequal?(a, b, strat = :regex) do
    !equal?(a, b, strat)
  end

  def a_b_to_string(a, b) do
    a_string =
      a
      |> Enum.map(fn el -> truncate_to_integer(el) end)
      |> Enum.join("")

    b_string =
      b
      |> Enum.map(fn el -> truncate_to_integer(el) end)
      |> Enum.join("")

    {a_string, b_string}
  end

  def truncate_to_integer(element) do
    Regex.replace(~r/\..+/, "#{element}", "")
  end

  # for the large lists, break them down.
  # use recursion -> must find the first index that matches a == b
end
