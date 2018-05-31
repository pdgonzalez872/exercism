defmodule LinkedList do
  def new() do
    []
  end

  def length(list) do
    Enum.count(list)
  end

  def empty?(list) do
    LinkedList.length(list) == 0
  end

  def push(list, el) do
    [el | list]
  end

  def peek(list) do
    if empty?(list) do
      {:error, :empty_list}
    else
      [v | _] = list
      {:ok, v}
    end
  end

  def tail([]), do: {:error, :empty_list}

  def tail(list) do
    [h | t] = list
    {:ok, t}
  end

  def pop([]), do: {:error, :empty_list}

  def pop(list) do
    [h | t] = list
    {:ok, h, t}
  end

  def from_list([]), do: []

  def from_list(list) do
    list
  end

  def to_list(list), do: list

  def reverse([]), do: []

  def reverse(list) do
    end_range = LinkedList.length(list) - 1

    Enum.reduce(end_range..0, [], fn el, acc ->
      acc ++ [Enum.at(list, el)]
    end)
  end

  def last_element([]), do: {:error, :empty_list}
  def last_element([last]), do: last

  def last_element(list) do
    [h | t] = list

    last_element(t)
  end
end
