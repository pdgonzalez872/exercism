defmodule PrimeTest do
  use ExUnit.Case
  doctest Prime

  test "is prime 1" do
    assert Prime.is_prime?(541) == true
    assert Prime.is_prime?(13) == true
  end

  test "first prime" do
    assert Prime.nth(1) == 2
  end

  test "second prime" do
    assert Prime.nth(2) == 3
  end

  test "sixth prime" do
    assert Prime.nth(6) == 13
  end

  test "100th prime" do
    assert Prime.nth(100) == 541
  end

  test "weird case" do
    catch_error(Prime.nth(0))
  end
end
