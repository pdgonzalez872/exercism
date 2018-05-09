defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """

  @max_range(26)

  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.split("")
    |> Enum.filter(fn(el)-> el != "" end)
    |> Enum.map(fn(el)-> process_letter(el, shift) end)
    |> Enum.join("")
  end


  def process_letter(" ", _), do: " "

  def process_letter(letter, shift) when is_binary(letter) do
    %{letter: _, list: list} = create_data_for_letter(letter)
    Enum.at(list, shift_value(shift))
  end

  def create_data_for_letter(letter) do
    # Nice list comprehension pattern, source:
    # http://elixir-recipes.github.io/strings/list-with-alphabet/
    # TODO: Refactor, use translate_utf_list instead
    lowercase = for n <- ?a..?z, do: << n :: utf8 >>
    uppercase = for n <- ?A..?Z, do: << n :: utf8 >>
    lowercase_minus_a = for n <- ?b..?z, do: << n :: utf8 >>
    uppercase_minus_A = for n <- ?B..?Z, do: << n :: utf8 >>

    result = %{letter: letter}

    list =
      cond do
        letter == "a" ->
          translate_utf_list(?a..?z)

        letter == "z" ->
          translate_utf_list(?z..?a)

        letter == "A" ->
          translate_utf_list(?A..?Z)

        letter == "Z" ->
          translate_utf_list(?Z..?A)

        Enum.member?(lowercase_minus_a, letter) ->
          create_alphabet_list(lowercase, letter)

        Enum.member?(uppercase_minus_A, letter) ->
          create_alphabet_list(uppercase, letter)

        true ->
          {number, ""} = Integer.parse(letter)
          create_alphabet_list(:rest, letter)
      end
    Map.put(result, :list, list)
  end

  def translate_utf_list(range) do
    Enum.map(range, fn(el) -> << el :: utf8 >> end)
  end

  defp create_alphabet_list(:rest, letter) do
    letter
  end

  defp create_alphabet_list(original_list, letter) when is_binary(letter) do
    start_index = Enum.find_index(original_list, fn el -> el == letter end)
    tail = Enum.slice(original_list, start_index, length(original_list))
    head = Enum.slice(original_list, 0, start_index)

    tail ++ head
  end

  defp shift_value(shift) do
    if div(shift, @max_range) > 0 do
      shift - @max_range
    else
      shift
    end
  end
end
