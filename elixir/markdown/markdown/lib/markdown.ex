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
    |> handle_list()
  end

  defp process(line) do
    cond do
      String.starts_with?(line, "*") && String.starts_with?(line, "#") ->
        line
        |> parse_header_md_level()
        |> enclose_with_header_tag()

      String.starts_with?(line, "#") ->
        line
        |> parse_header_md_level()
        |> enclose_with_header_tag()

      String.starts_with?(line, "*") ->
        parse_list_md_level(line)

      true ->
        handle_line(line)
    end
  end

  def handle_line(line) do
    line
    |> String.split()
    |> join_words_with_tags()
    |> enclose_text_with_tags("<p>", "</p>")
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_md_level(l) do
    l
    |> String.trim_leading("* ")
    |> String.split()
    |> join_words_with_tags()
    |> enclose_text_with_tags("<li>", "</li>")
  end

  def enclose_text_with_tags(input, open_tag, close_tag) do
    open_tag <> input <> close_tag
  end

  defp enclose_with_header_tag({header_level, header_text}) do
    open_tag = "<h#{header_level}>"
    close_tag = "</h#{header_level}>"
    enclose_text_with_tags(header_text, open_tag, close_tag)
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

  defp handle_list(list_text) do
    list_text
    # This only gets the first instance. Nice.
    |> String.replace("<li>", "<ul><li>", global: false)
    # This only gets the last instance. Nice x2
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
