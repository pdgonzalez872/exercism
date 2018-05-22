defmodule Words do
  def count(sentence) do
    sentence
    |> remove_punctuation()
    |> split_underscores()
    |> String.split(" ")
    |> Enum.map(fn el -> String.downcase(el) end)
    |> Enum.filter(fn el -> el != "" end)
    |> Enum.reduce(%{}, fn el, acc ->
      if Map.has_key?(acc, el) do
        Map.put(acc, "#{el}", acc["#{el}"] + 1)
      else
        Map.put(acc, el, 1)
      end
    end)
  end

  def remove_punctuation(sentence) do
    Regex.replace(~r/[,!&@$%^:+]+/, sentence, "")
  end

  def split_underscores(sentence) do
    Regex.replace(~r/[_]+/, sentence, " ")
  end
end
