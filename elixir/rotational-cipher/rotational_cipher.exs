defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  @max_range(26)

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do

    # uppercase -> Rotate between uppercases only, 65..90
    # lowercase -> Rotate between lowercases only, 97..122
    # comma     -> Symbol stays the same

    ranges = %{lowercase: 97..122, uppercase: 65..90}

    # case shift > 26
    # case shift == 26 -> no shift, call this function with 0
    # case shift < 26 -> add

    result =
      text <> <<0>>
      |> :binary.bin_to_list()
      |> IO.inspect()
      |> Enum.map(fn(el) -> el + shift end)
      |> Enum.drop(-1)
      |> Enum.to_list()
      |> List.to_string()
  end

  def process_single_char(char, shift) do

    case char do
      ?a..?z ->

      ?A..?Z ->

      _ ->
        # symbols
    end
  end

  def create_lookup() do
    65..122
    |> Enum.reduce(%{}, fn(el, acc) ->
      if Map.has_key?(acc, el) do
        nil
      else
        Map.put(acc, el, <<el>>)
      end
    end)
  end

  def calculate_wrap_around(range, shift) do

  end

  # when it goes over -> divide by 26, then use remainder to lookup

  def create_lookup_for_all_letters(shift) do
    lookup = %{}

    lowercase =
      ?a..?z
      |> Enum.map(fn(n)->
        n
      end)
      |> Enum.with_index(0)


    lookup
    |> Map.put(:lowercase, lowercase)
  end
end
