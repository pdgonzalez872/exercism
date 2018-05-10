defmodule PauloRotaTest do
  use ExUnit.Case

  describe "create_data_for_letter/1" do
    test "returns a data structure with the correct data mappings - a" do
      result = PauloRota.create_data_for_letter("a")

      list = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
              "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
      assert result == %{letter: "a", list: list}
    end

    test "returns a data structure with the correct data mappings - z" do
      result = PauloRota.create_data_for_letter("z")

      list = ["z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y"]
      assert result == %{letter: "z", list: list}
    end

    test "returns a data structure with the correct data mappings - A" do
      result = PauloRota.create_data_for_letter("A")

      list = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
      assert result == %{letter: "A", list: list}
    end

    test "returns a data structure with the correct data mappings - Z" do
      result = PauloRota.create_data_for_letter("Z")

      list = ["Z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y"]
      assert result == %{letter: "Z", list: list}
    end

    test "returns a data structure with the correct data mappings - b" do
      result = PauloRota.create_data_for_letter("b")

      list = ["b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "a"]
      assert result == %{letter: "b", list: list}
    end

    test "returns a data structure with the correct data mappings - B" do
      result = PauloRota.create_data_for_letter("B")

      list = ["B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "A"]
      assert result == %{letter: "B", list: list}
    end
  end

  test "rotate a by 1" do
    plaintext = "a"
    shift = 1
    assert PauloRota.rotate(plaintext, shift) == "b"
  end

  test "rotate a by 26, same output as input" do
    plaintext = "a"
    shift = 26
    assert PauloRota.rotate(plaintext, shift) == "a"
  end

  test "rotate a by 0, same output as input" do
    plaintext = "a"
    shift = 0
    assert PauloRota.rotate(plaintext, shift) == "a"
  end

  test "rotate m by 13" do
    plaintext = "m"
    shift = 13
    assert PauloRota.rotate(plaintext, shift) == "z"
  end

  test "rotate n by 13 with wrap around alphabet" do
    plaintext = "n"
    shift = 13
    assert PauloRota.rotate(plaintext, shift) == "a"
  end

  test "rotate capital letters" do
    plaintext = "OMG"
    shift = 5
    assert PauloRota.rotate(plaintext, shift) == "TRL"
  end

  test "rotate spaces" do
    plaintext = "O M G"
    shift = 5
    assert PauloRota.rotate(plaintext, shift) == "T R L"
  end

  test "rotate numbers" do
    plaintext = "Testing 1 2 3 testing"
    shift = 4
    assert PauloRota.rotate(plaintext, shift) == "Xiwxmrk 1 2 3 xiwxmrk"
  end

  test "rotate punctuation" do
    plaintext = "Let's eat, Grandma!"
    shift = 21
    assert PauloRota.rotate(plaintext, shift) == "Gzo'n zvo, Bmviyhv!"
  end

  test "rotate all letters" do
    plaintext = "The quick brown fox jumps over the lazy dog."
    shift = 13

    assert PauloRota.rotate(plaintext, shift) ==
             "Gur dhvpx oebja sbk whzcf bire gur ynml qbt."
  end
end
