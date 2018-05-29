defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """

  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(input) do
    input
    |> String.split("", trim: true)
    |> split_into_sections("")
  end

  defp split_into_sections([], output), do: output

  defp split_into_sections(list, output) do
    [letter | _] = list

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

  @spec decode(String.t()) :: String.t()
  def decode(""), do: ""

  def decode(input) do
    if  does_not_contain_digit(input) do
      input
    else
      input
      |> String.split("", trim: true)
      |> destructure_input("")
    end
  end

  # Name clash with `Kernel.destructure/2`, so renamed mine.
  defp destructure_input([], output), do: output

  defp destructure_input(list, output) do
    [element | rest] = list

    if is_letter(element) do
      new_output = output <> element
      destructure_input(rest, new_output)

    else
      digits = Enum.take_while(list, fn el -> is_digit(el) end)

      index_on_non_digit = Enum.count(digits)
      new_list = Enum.drop(list, index_on_non_digit + 1)
      target_letter = Enum.at(list, index_on_non_digit)

      new_output =
        digits
        |> create_repetitions()
        |> create_new_output(target_letter)

      destructure_input(new_list, output <> new_output)
    end
  end

  defp create_repetitions(digits) do
    digits
    |> Enum.join("")
    |> String.to_integer()
  end

  defp create_new_output(repetitions, target_letter) do
    Enum.reduce(1..repetitions, "", fn _el, acc -> acc <> target_letter end)
  end

  defp does_not_contain_digit(input) do
    !Regex.match?(~r/\d/, input)
  end

  defp is_digit(element) do
    Regex.match?(~r/^\d/, element)
  end

  defp is_letter(element) do
    !is_digit(element)
  end
end
