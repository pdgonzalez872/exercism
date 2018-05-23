defmodule Acronym do

  def abbreviate(input) when is_binary(input) do
    input
    |> handle_punctuation()
    |> split_sentence_by_spaces()
    |> take_first_letters_from_each_element()
    |> combine_first_letters()
  end

  def handle_punctuation(input) do
    input
    |> String.replace("-", " ")
  end

  def split_sentence_by_spaces(input), do:  String.split(input, " ")

  def take_first_letters_from_each_element(input) do
    input
    |> Enum.map(fn(el)->
      cond do
        has_inconsistent_case?(el) ->
          require IEx; IEx.pry
          # find first upper, split there, send
        true ->
          [[first]] = Regex.scan(~r/^./, el)
          String.upcase(first)
      end
    end)
  end

  @doc """
  The assumption here is that words only have 1 uppercase letter.
  If 2, it is inconsistent. If none, consistent as well.

  Examples:

  iex> Acronym.has_inconsistent_case?("Paulo")
  false

  iex> Acronym.has_inconsistent_case?("paulo")
  false

  iex> Acronym.has_inconsistent_case?("PauLo")
  true
  """
  def has_inconsistent_case?(input) do
    count_of_upper =
      input
      |> String.split("")
      |> Enum.filter(fn(el)-> el != "" end)
      |> Enum.reduce(0, fn(el, acc)->
        if el == String.upcase(el) do
          acc = acc + 1
        end
        acc # unsafe var here, cool, let's fix this later.
      end)

    if count_of_upper > 1 do
      true
    else
      false
    end
  end

  def combine_first_letters(input), do: Enum.join(input, "")

end
