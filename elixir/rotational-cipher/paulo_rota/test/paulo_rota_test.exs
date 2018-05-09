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

      list = ["z", "y", "x", "w", "v", "u", "t", "s", "r", "q",
              "p", "o", "n", "m", "l", "k", "j", "i", "h", "g",
              "f", "e", "d", "c", "b", "a"]
      assert result == %{letter: "z", list: list}
    end

    test "returns a data structure with the correct data mappings - A" do
      result = PauloRota.create_data_for_letter("A")

      list = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
      assert result == %{letter: "A", list: list}
    end

    test "returns a data structure with the correct data mappings - Z" do
      result = PauloRota.create_data_for_letter("Z")

      list = ["Z", "Y", "X", "W", "V", "U", "T", "S", "R", "Q", "P", "O", "N", "M", "L", "K", "J", "I", "H", "G", "F", "E", "D", "C", "B", "A"]
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
end
