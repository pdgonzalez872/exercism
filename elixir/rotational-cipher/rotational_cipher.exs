defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    # Enum.split(text, "")
    # |> Enum.map(fn(x)-> x end)
    char_list = to_char_list(text)
    Enum.map(char_list, fn(x) -> to_string(x + shift)  end)
    |> Enum.join(" ")

  end
end
