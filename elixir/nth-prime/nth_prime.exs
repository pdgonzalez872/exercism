defmodule Prime do
  @doc """
  Given a number n, determine what the nth prime is.

  By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that
  the 6th prime is 13.

  If your language provides methods in the standard library to deal with prime
  numbers, pretend they don't exist and implement them yourself.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise("Not a prime.")
  def nth(1), do: 2

  def nth(non_neg_integer) when is_integer(non_neg_integer) do
    # receive a number, have to loop while you find a certain number of primes.
    # If you pass in 6, it gives you the first 6.

    nth(%{nth: non_neg_integer, primes: [1, 2], target: 3})
  end

  def nth(state) when is_map(state) do
    if Enum.count(state.primes) == state.nth + 1 do
      Enum.at(state.primes, -1)
    else
      new_state =
        if is_prime?(state.target) do
          Map.put(state, :primes, state.primes ++ [state.target])
        else
          state
        end

      nth(Map.put(new_state, :target, state.target + 1))
    end
  end

  @doc """
  Returns true if a number is prime, false otherwise.

  Prime number is divisible by itself and 1 only

  You only need to check if prime up until the square root of a target number
  """
  def is_prime?(1), do: true
  def is_prime?(2), do: true
  def is_prime?(3), do: true

  def is_prime?(non_neg_integer) do
    if rem(non_neg_integer, 2) == 0 do
      false
    else
      ceiling = :math.sqrt(non_neg_integer) |> trunc()

      divisible_by =
        Enum.filter(3..ceiling, fn el ->
          rem(non_neg_integer, el) == 0
        end)

      Enum.count(divisible_by) == 0
    end
  end
end
