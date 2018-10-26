defmodule MarkdownTest do
  use ExUnit.Case
  doctest Markdown

  test "greets the world" do
    assert Markdown.hello() == :world
  end
end
