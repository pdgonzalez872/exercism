if !System.get_env("EXERCISM_TEST_EXAMPLES") do
  Code.load_file("isogram.exs", __DIR__)
end

ExUnit.start()
ExUnit.configure(trace: true)

defmodule IsogramTest do
  use ExUnit.Case

  test "isogram lowercase" do
    assert Isogram.isogram?("subdermatoglyphic")
  end

  test "not isogram lowercase " do
    refute Isogram.isogram?("eleven")
  end

  test "isogram uppercase" do
    assert Isogram.isogram?("DEMONSTRABLY")
  end

  test "not isogram uppercase" do
    refute Isogram.isogram?("ALPHABET")
  end

  test "isogram with dash" do
    assert Isogram.isogram?("hjelmqvist-gryb-zock-pfund-wax")
  end

  @tag :pending
  test "not isogram with dash" do
    refute Isogram.isogram?("twenty-five")
  end

  @tag :pending
  test "phrase is isogram" do
    assert Isogram.isogram?("emily jung schwartzkopf")
  end

  @tag :pending
  test "phrase is not isogram" do
    refute Isogram.isogram?("the quick brown fox")
  end
end
