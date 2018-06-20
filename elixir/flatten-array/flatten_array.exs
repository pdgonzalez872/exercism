defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([]), do: []

  def flatten([head|tail] = list) when is_list(list) do
    flatten(head) ++ flatten(tail)
  end

  def flatten(int) when is_integer(int) do
    [int]
  end
end
