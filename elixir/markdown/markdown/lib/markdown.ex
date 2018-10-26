defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

  """
  @spec parse(String.t()) :: String.t()
  def parse(document) do
    document
    |> String.split("\n")
    |> Enum.map(fn line -> process(line) end)
    |> Enum.join()
    |> patch()
  end

  defp process(line) do
    if String.starts_with?(line, "#") || String.starts_with?(line, "*") do
      if String.starts_with?(line, "#") do
        #require IEx; IEx.pry
        line
        |> parse_header_md_level()
        |> enclose_with_header_tag()
      else
        parse_list_md_level(line)
      end
    else
      line
      |> String.split()
      |> enclose_with_paragraph_tag()
    end
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    t = String.split(String.trim_leading(l, "* "))
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_header_tag({hl, htl}) do
    "<h" <> hl <> ">" <> htl <> "</h" <> hl <> ">"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(split_sentence) do
    split_sentence
    |> Enum.map(fn word ->
      word
      |> translate_to_tag("__", "strong")
      |> translate_to_tag("_", "em")
    end)
    |> Enum.join(" ")
  end

  def translate_to_tag(word, tag_mapping, tag_name) do
    word
    |> String.replace_prefix(tag_mapping, "<#{tag_name}>")
    |> String.replace_suffix(tag_mapping, "</#{tag_name}>")
  end

  defp patch(l) do
    String.replace_suffix(
      String.replace(l, "<li>", "<ul>" <> "<li>", global: false),
      "</li>",
      "</li>" <> "</ul>"
    )
  end
end
