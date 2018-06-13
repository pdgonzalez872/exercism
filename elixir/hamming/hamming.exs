defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance('', ''), do: {:ok, 0}

  def hamming_distance(strand1, strand2) do
    cond do
      strand1 == strand2 ->
        {:ok, 0}

      Enum.count(strand1) != Enum.count(strand2) ->
        {:error, "Lists must be the same length"}

      true ->
        not_equal_count =
          Enum.zip(strand1, strand2)
          |> Enum.reduce(0, fn({s1, s2}, acc) ->
            if s1 != s2 do
              acc + 1
            else
              acc
            end
          end)
        {:ok, not_equal_count}
    end
  end
end
