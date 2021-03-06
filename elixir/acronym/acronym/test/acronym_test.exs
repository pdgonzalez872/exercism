defmodule AcronymTest do
  use ExUnit.Case
  doctest Acronym

  test "it produces acronyms from title case" do
    assert Acronym.abbreviate("Portable Networks Graphic") === "PNG"
  end

  test "it produces acronyms from lower case" do
    assert Acronym.abbreviate("Ruby on Rails") === "ROR"
  end

  test "it produces acronyms from inconsistent case" do
    assert Acronym.abbreviate("HyperText Markup Language") === "HTML"
  end

  test "it ignores punctuation" do
    assert Acronym.abbreviate("First in, First out") === "FIFO"
  end

  test "it produces acronyms ignoring punctuation and casing" do
    assert Acronym.abbreviate("Complementary Metal-Oxide semiconductor") === "CMOS"
  end
end
