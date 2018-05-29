defmodule RunLengthEncoder do

  def encode(""), do: ""

  def encode(input) do
    input
    |> String.split("", trim: true)
    |> split_into_sections("")
  end

  def split_into_sections([], output), do: output

  def split_into_sections(list, output) do
    [letter | _] = list

    letter_change_index = Enum.find_index(list, fn e -> e != letter end)

    repetition_count =
      list
      |> Enum.take_while(fn new_list_el -> letter == new_list_el end)
      |> Enum.count()

    new_output =
      if repetition_count == 1 do
        output <> "#{letter}"
      else
        output <> "#{repetition_count}#{letter}"
      end

    split_into_sections(Enum.drop(list, repetition_count), new_output)
  end

  def decode(""), do: ""

  def decode(input) do
    cond do
       does_not_contain_digit(input)->
        input
      true ->
        input
        |> String.split("", trim: true)
        |> destructure_input("")
    end
  end

  # Name clash with `Kernel.destructure/2`, so renamed mine.
  def destructure_input([], output), do: output

  def destructure_input(list, output) do
    [element | rest] = list

    # go through the list, check if the first element is a letter, if so, add to the output remove the letter and move on
    # If not, must find the first letter (non-digit), combine the numbers until the letter make it an integer and list comp into a string.

    cond do
      # handles a letter, eg: "W"
      !is_digit(element) ->
        new_output = output <> element
        destructure_input(rest, new_output)

      true ->
        # find the first letter
        digits = Enum.take_while(list, fn el -> is_digit(el) end)
        index_on_non_digit = Enum.count(digits)
        target_letter = Enum.at(list, index_on_non_digit)

        repetitions =
          digits
          |> Enum.join("")
          |> String.to_integer()

        # build output
        new_output = Enum.reduce(1..repetitions, "", fn el, acc -> acc <> target_letter end)

        # build new list
        new_list = Enum.drop(list, index_on_non_digit + 1)

        destructure_input(new_list, output <> new_output)
    end
  end

  def does_not_contain_digit(input) do
    !Regex.match?(~r/\d/, input)
  end

  def is_digit(element) do
    Regex.match?(~r/^\d/, element)
  end
end
