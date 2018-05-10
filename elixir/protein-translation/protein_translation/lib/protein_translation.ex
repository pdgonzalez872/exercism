defmodule ProteinTranslation do

  @rna_size(3)

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {atom, list(String.t())}
  def of_rna(rna) do
    rna
    |> String.split("")
    |> Enum.filter(&(&1 != ""))
    |> Enum.chunk_every(@rna_size)
    |> prepare_output()
    # |> Enum.map(fn el ->
    #   Enum.join(el, "")
    # end)
  end

  def prepare_output(nested_list) do
    nested_list
    |> Enum.map(fn el ->
      el
      |> Enum.join("")
      |> of_codon()
    end)
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    lookup_table()
    |> Enum.find(fn({k, _}) -> k == codon end)
    |> prepare_response()
  end

  def prepare_response({_, name}) do
    {:ok, name}
  end


  def lookup_table() do
    %{
      "UGU" => "Cysteine",
      "UGC" => "Cysteine",
      "UUA" => "Leucine",
      "UUG" => "Leucine",
      "AUG" => "Methionine",
      "UUU" => "Phenylalanine",
      "UUC" => "Phenylalanine",
      "UCU" => "Serine",
      "UCC" => "Serine",
      "UCA" => "Serine",
      "UCG" => "Serine",
      "UGG" => "Tryptophan",
      "UAU" => "Tyrosine",
      "UAC" => "Tyrosine",
      "UAA" => "STOP",
      "UAG" => "STOP",
      "UGA" => "STOP"
    }
  end
end
