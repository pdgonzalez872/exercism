defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    sorted_base = sort_letters(base)

    Enum.map(candidates, fn el ->
      to_match = sort_letters(el)
      if sorted_base == to_match do
        el
      else
        nil
      end
    end)
    |> Enum.filter(fn el -> !is_nil(el) end)
  end

  def sort_letters(word) do
    word
    |> String.split("", trim: true)
    |> Enum.join("")
  end
end
