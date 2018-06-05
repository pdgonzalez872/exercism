defmodule RNATranscription do

  @rna_mapping %{
    "G" => "C",
    "C" => "G",
    "T" => "A",
    "A" => "U"
  }

  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(input) do
    input
    |> to_string()
    |> String.split("", trim: true)
    |> Enum.map(fn el -> @rna_mapping["#{el}"] end)
    |> Enum.join("")
    |> to_charlist()
  end
end
