defmodule BeerSong do

  def verse(2) do
    """
    2 bottles of beer on the wall, 2 bottles of beer.
    Take one down and pass it around, 1 bottle of beer on the wall.
    """
  end

  def verse(1) do
    """
    1 bottle of beer on the wall, 1 bottle of beer.
    Take it down and pass it around, no more bottles of beer on the wall.
    """
  end

  def verse(0) do
    """
    No more bottles of beer on the wall, no more bottles of beer.
    Go to the store and buy some more, 99 bottles of beer on the wall.
    """
  end

  def verse(bottles_number) do
    """
    #{bottles_number} bottles of beer on the wall, #{bottles_number} bottles of beer.
    Take one down and pass it around, #{bottles_number - 1} bottles of beer on the wall.
    """
  end

  def lyrics(range) do
    range
    |> Enum.map(fn verse_number -> verse(verse_number) end)
    |> Enum.join("\n")
  end

  def lyrics() do
  99..0
  |> lyrics()
  end
end
