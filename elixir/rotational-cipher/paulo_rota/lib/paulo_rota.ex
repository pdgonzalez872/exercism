defmodule PauloRota do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.split("")
    |> Enum.filter(fn(el)-> el != "" end)
    |> Enum.map(fn(el)->
      el
      |> handle_type(shift)
      |> process_letter()
    end)
    |> Enum.join("")
  end

  def handle_type(element, shift) do
    cond do
      String.contains?("1234567890", element) ->
        {:integer, element, nil}

      String.contains?(" ", element) ->
        {:space, nil, nil}

      String.contains?("'/,!?.", element) ->
        {:integer, element, nil}

      true ->
        {:string, element, shift}
    end
  end

  def process_letter({:integer, number, _}), do: number
  def process_letter({:space, _, _}), do: " "
  def process_letter({:symbol, symbol, _}), do: symbol

  def process_letter({:string, letter, shift}) do
    %{letter: _, list: list} = create_data_for_letter(letter)
    Enum.at(list, shift_value(shift))
  end

  def create_data_for_letter(letter) do
    lowercase = Enum.map(?a..?z, fn(el) -> << el :: utf8 >> end)
    uppercase = Enum.map(?A..?Z, fn(el) -> << el :: utf8 >> end)

    result = %{letter: letter}

    list =
      if Enum.member?(lowercase, letter) do
        create_alphabet_list(lowercase, letter)
      else
        create_alphabet_list(uppercase, letter)
      end
    Map.put(result, :list, list)
  end

  defp create_alphabet_list(original_list, letter) do
    start_index = Enum.find_index(original_list, fn el -> el == letter end)
    tail = Enum.slice(original_list, start_index, length(original_list))
    head = Enum.slice(original_list, 0, start_index)

    tail ++ head
  end

  defp shift_value(shift) do
    max_alphabet_range = 26

    if div(shift, max_alphabet_range) > 0 do
      shift - max_alphabet_range
    else
      shift
    end
  end
end
