defmodule Isogram do
  def isogram?(word) do
    original_split =
      Regex.run(~r/^[a-zA-Z\s]+/, word)
      |> Enum.join("") # ["thisistheresult"]
      |> String.replace(" ", "")
      |> String.split("", trim: true) # the result here is split letters

    map_set =
      original_split
      |> MapSet.new()

    Enum.count(original_split) == Enum.count(map_set)
  end
end
