defmodule RNATranscription do
  @rna_mapping %{
    "G" => "C",
    "C" => "G",
    "T" => "A",
    "A" => "U"
  }

  def to_rna(input) do
    input
    |> to_string()
    |> String.split("", trim: true)
    |> Enum.map(fn el -> @rna_mapping["#{el}"] end)
    |> Enum.join("")
    |> to_charlist()
  end
end
