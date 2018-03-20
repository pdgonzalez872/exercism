require IEx

defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    case length(strand) do
      0 ->
        0
      _ ->
        Enum.count(strand, fn(x) -> x == nucleotide end)
    end
  end

  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  def histogram([]), do: %{?A => 0, ?T => 0, ?C => 0, ?G => 0}

  @spec histogram([char]) :: map
  def histogram(strand) do
    # Using binary13's solution, I was stumped and liked his the most.
    # Even though a little repetitive, the intent is very clear. +1
    %{
      ?A => count(strand, ?A),
      ?T => count(strand, ?T),
      ?C => count(strand, ?C),
      ?G => count(strand, ?G)
    }
  end
end
