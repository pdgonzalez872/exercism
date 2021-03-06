defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    prepared_base = prepare_word(base)

    candidates
    |> Enum.with_index()
    |> remove_source_word(base)
    |> prepare_candidates()
    |> Enum.map(fn el ->
      {e, index} = el

      if prepared_base == e do
        Enum.at(candidates, index)
      else
        nil
      end
    end)
    |> Enum.filter(fn el -> !is_nil(el) end)
  end

  def prepare_word(word) do
    word
    |> String.split("", trim: true)
    |> Enum.map(fn e -> String.downcase(e) end)
    |> Enum.sort()
    |> Enum.join("")
  end

  def prepare_candidates(candidates) do
    candidates
    |> Enum.map(fn el ->
      {e, index} = el
      {prepare_word(e), index}
    end)
  end

  def remove_source_word(candidates, source_word) do
    Enum.filter(candidates, fn el ->
      {e, _index} = el
      !(String.downcase(source_word) == String.downcase(e))
    end)
  end
end
