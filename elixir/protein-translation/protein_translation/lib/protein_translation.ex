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
    |> Enum.map(fn el ->
      el
      |> Enum.join("")
      |> of_codon()
      |> prepare_response_codon()
    end)
    |> Enum.map(fn({_status, name})-> name end)
    |> stop_translation_if_stop_condon_is_present()
    |> Enum.uniq()
    |> prepare_response_rna
  end

  def prepare_output(nested_list) do
    nested_list
  end

  def prepare_response_rna(result) do
    {:ok, result}
  end

  def stop_translation_if_stop_condon_is_present(list) do
    first_stop = Enum.find_index(list, fn(el)-> el == "STOP"end)

    if is_nil(first_stop) do
      list
    else
      Enum.slice(list, 0, first_stop)
    end
  end

  @doc """
  Given a codon, return the corresponding protein
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
    lookup_table()
    |> Enum.find(fn({k, _v}) -> k == codon end)
    |> prepare_response_codon()
  end

  def prepare_response_codon({_codon, name}) do
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
