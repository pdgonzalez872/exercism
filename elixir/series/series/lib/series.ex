defmodule StringSeries do

  def slices(binary, slice_size) when slice_size == 1 do
    binary
    |> String.split("", trim: true)
    |> Enum.chunk_every(1)
    |> List.flatten()
  end

  def slices(_, slice_size) when slice_size <= 0, do: []

  def slices(binary, slice_size) do

    split_binary = binary |> String.split("", trim: true)
    with_index = split_binary |> Enum.with_index()

    transformation =
      binary
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.map(fn {el, index} ->

        target_index = slice_size - 1 + index

        if target_index < length(split_binary) do
          result = Enum.reduce(index..target_index, "", fn(range_el, acc) ->
            acc <> Enum.at(split_binary, range_el)
          end)
        else

        end
      end)
      |> Enum.filter(fn el -> !is_nil(el) end)
  end

  def debug(list) do
    require IEx; IEx.pry
  end
end
