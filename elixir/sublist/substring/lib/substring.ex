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
    # Deal with correct precision "1.0" vs "1"

    large_list_max = 100

    cond do
      Enum.count(a) > large_list_max || Enum.count(b) > large_list_max ->
        :list
      contains_float?(a) || contains_float?(b) ->
        :list
      true ->
        :regex
    end
  end

  def contains_float?(list) do
    Enum.find(list, fn el -> is_float(el) end)
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

  def sublist?(a, b, :list) do
    a_length = Enum.count(a)
    target_value = Enum.at(a, 0)

    # Pick where to start -> get multiple places of "where to start"
    # get first or (first + second -> optmization) item from a. Find indexes of where those are in b

    places_to_start =
      b
      |> Enum.with_index()
      |> Enum.reduce([], fn el, acc ->
        {value, index} = el
        if value == target_value do
          acc ++ [index]
        else
          acc
        end
      end)

    # for each of those indexes, create lists of length a
    potential_matches =
      places_to_start
      |> Enum.map(fn el ->
        Enum.slice(b, el, a_length)
      end)

    # Check if a is equal to a sublist. That means a is included in b.
    Enum.any?(potential_matches, fn sublist_from_b ->
      a == sublist_from_b
    end)
  end

  def partition_list(list, desired_length) do

  end

  def equal?(a, b, :regex) do
    {a_string, b_string} = a_b_to_string(a, b)
    a_string == b_string
  end

  def equal?(a, b, :list) do
    a_sum = Enum.reduce(a, 0, fn el, acc -> acc + el end)
    b_sum = Enum.reduce(b, 0, fn el, acc -> acc + el end)
    a == b
  end

  def unequal?(a, b, strat = :regex) do
    !equal?(a, b, strat)
  end

  def unequal?(a, b, :list) do

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
