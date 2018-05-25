defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """

  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_, slice_size) when slice_size <= 0, do: []

  def slices(binary, slice_size) do

    split_binary = binary |> String.split("", trim: true)

    binary
    |> String.split("", trim: true)
    |> Enum.with_index()
    |> Enum.map(fn {_el, index} ->

      target_index = slice_size - 1 + index

      if target_index < length(split_binary) do
        Enum.reduce(index..target_index, "", fn(range_el, acc) ->
          acc <> Enum.at(split_binary, range_el)
        end)
      end
    end)
    |> Enum.filter(fn el -> !is_nil(el) end)
  end
end
