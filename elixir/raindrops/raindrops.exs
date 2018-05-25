defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.

  I don't quite like my solution. I think it would be more intesting to have
  done something like:
  https://rosettacode.org/wiki/Factors_of_an_integer#Elixir
  Though, I do like how explicit this solution is. There is not much to it.
  If another rule would be introduced, it would be a matter of adding another
  case. Interesting exercise.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(input) do
    input
    |> determine_case()
  end

  def handle_case({input, :base}), do: "#{input}"

  def determine_case(input) do
    cond do
      divisible_by_all(input) -> "PlingPlangPlong"
      divisible_by(input, 3) && divisible_by(input, 5) -> "PlingPlang"
      divisible_by(input, 3) && divisible_by(input, 7) -> "PlingPlong"
      divisible_by(input, 5) && divisible_by(input, 7) -> "PlangPlong"
      divisible_by(input, 3) -> "Pling"
      divisible_by(input, 5) -> "Plang"
      divisible_by(input, 7) -> "Plong"
      true -> "#{input}"
    end
  end

  def divisible_by(input, n) do
    rem(input, n) == 0
  end

  def divisible_by_all(input) do
    divisible_by(input, 3) && divisible_by(input, 5) && divisible_by(input, 7)
  end
end
