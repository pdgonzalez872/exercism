defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn {k, v}, first_acc ->
      Enum.reduce(v, %{}, fn word, second_acc ->
        Map.merge(first_acc, Map.put(second_acc, String.downcase(word), k))
      end)
    end)
  end
end
