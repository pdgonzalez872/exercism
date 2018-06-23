defmodule ETL do
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn {k, v}, first_acc ->
      Enum.reduce(v, %{}, fn word, second_acc ->
        Map.merge(first_acc, Map.put(second_acc, String.downcase(word), k))
      end)
    end)
  end
end
