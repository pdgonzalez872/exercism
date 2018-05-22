defmodule TwelveDays do


  # common ending -> "and ..."
  # exception ending -> the first one, without "and"

  def verse(1) do
    build_verse(1)
  end

  def build_verse(verse_number) do
    verse_data =
      verse_number
      |> get_verse_data()
      |> Enum.at(0)
    "On the #{verse_data.ordinal} day of Christmas my true love gave to me, #{verse_data.item}."
  end

  defp first_verse_by_itself() do
    "On the first day of Christmas my true love gave to me, a Partridge in a Pear Tree."
  end

  def verse_list() do
    [
      %{verse_number: 1,  cardinal: "one", ordinal: "first", item: "a Partridge in a Pear Tree"},
      %{verse_number: 2,  cardinal: "two", ordinal: "second", item: "Turtle Doves"},
      %{verse_number: 3,  cardinal: "three", ordinal: "third", item: "French Hens"},
      %{verse_number: 4,  cardinal: "four", ordinal: "fourth", item: "Calling Birds"},
      %{verse_number: 5,  cardinal: "five", ordinal: "fifth", item: "Gold Rings"},
      %{verse_number: 6,  cardinal: "six", ordinal: "sixth", item: "Geese-a-Laying"},
      %{verse_number: 7,  cardinal: "seven", ordinal: "seventh", item: "Swans-a-Swimming"},
      %{verse_number: 8,  cardinal: "eight", ordinal: "eighth", item: "Maids-a-Milking"},
      %{verse_number: 9,  cardinal: "nine", ordinal: "ninth", item: "Ladies Dancing"},
      %{verse_number: 10, cardinal: "ten", ordinal: "tenth", item: "Lords-a-Leaping"},
      %{verse_number: 11, cardinal: "eleven", ordinal: "elenventh", item: "Pipers Piping"},
      %{verse_number: 12, cardinal: "twelve", ordinal: "twelfth", item: "Drummers Drumming"},
    ]
  end

  def get_verse_data(n) do
    Enum.filter(verse_list, fn(el)-> el.verse_number == n end)
  end
end
