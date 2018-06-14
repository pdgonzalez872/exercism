defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t()) :: boolean
  def isogram?(sentence) do
    original_split =
      Regex.run(~r/^[a-zA-Z\s]+/, sentence)
      |> Enum.join("") # ["thisistheresult"]
      |> String.replace(" ", "")
      |> String.split("", trim: true) # the result here is split letters

    map_set =
      original_split
      |> MapSet.new()

    Enum.count(original_split) == Enum.count(map_set)
  end
end
