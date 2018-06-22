defmodule ETL do
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn {k, v}, first_acc ->
      Enum.map(v, fn el ->
        a = el |> String.downcase()
        Map.put(first_acc, a, k)

      require IEx; IEx.pry
      end)
    end)
    |> Enum.reduce(%{}, fn el, acc ->
      require IEx; IEx.pry
    end)
  end
end

