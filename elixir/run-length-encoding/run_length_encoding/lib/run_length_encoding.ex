defmodule RunLengthEncoder do
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
      Enum.take_while(list, fn new_list_el ->
        letter == new_list_el
      end)
      |> Enum.count()

    new_output =
      if repetition_count == 1 do
        output <> "#{letter}"
      else
        output <> "#{repetition_count}#{letter}"
      end

    split_into_sections(Enum.drop(list, repetition_count), new_output)
  end
end
