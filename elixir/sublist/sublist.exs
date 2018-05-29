defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
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

      unequal?(a, b, strat) ->
        :unequal

      true ->
        :sheep
    end
  end

  def choose_strategy(a, b) do
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
    sublist?(b, a, :list)
  end

  def sublist?(a, b, :regex) do
    {a_string, b_string} = a_b_to_string(a, b)

    {:ok, r} = Regex.compile(a_string)
    Regex.match?(r, b_string)
  end

  def sublist?(a, b, :list) do
    b
    |> Enum.with_index()
    |> Enum.reduce([], fn el, acc ->
      {value, index} = el

      if value === Enum.at(a, 0) do
        acc ++ [index]
      else
        acc
      end
    end)
    |> Enum.map(fn el -> Enum.slice(b, el, Enum.count(a)) end)
    |> Enum.any?(fn sublist_from_b -> a == sublist_from_b end)
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

  def unequal?(a, b, strat) do
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
end
