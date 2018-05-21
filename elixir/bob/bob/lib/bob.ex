defmodule Teenager do

  # Thoughts:
  # - I don't like how I constantly have to call Enum.filter to remove the empty
  #   spaces after splitting the string

  def hey(phrase) do
    type =
      cond do
        check_for_silence(phrase) ->
          :silence
        check_for_only_numbers_and_symbols(phrase) ->
          :base
        ends_with_question_mark(phrase) ->
          :question
        all_caps(phrase) ->
          :shouting
        true ->
          :base
      end
    response(type)
  end

  defp response(:question), do: "Sure."
  defp response(:shouting), do: "Whoa, chill out!"
  defp response(:base), do: "Whatever."
  defp response(:silence), do: "Fine. Be that way!"

  defp all_caps(phrase) do
    result =
      phrase
      |> String.split("")
      |> Enum.filter(fn(el)-> el != "" end)
      |> Enum.map(fn(el)-> String.upcase(el) end)
      |> Enum.join("")
    phrase == result
  end

  defp ends_with_question_mark(phrase) do
    last_char =
      phrase
      |> String.split("")
      |> Enum.filter(fn(el)-> el != "" end)
      |> Enum.at(-1)

    last_char == "?"
  end

  defp check_for_silence(phrase) do
    String.trim(phrase) == ""
  end

  defp check_for_only_numbers_and_symbols(phrase) do
    without_numbers = Regex.replace(~r/[0-9]+/, phrase, "")
    result = without_special_characters = Regex.replace(~r/[!@#$%^&*,]+/, without_numbers, "")

    String.trim(result) == ""
  end
end
