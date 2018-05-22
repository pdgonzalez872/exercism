defmodule TwelveDays do

  # Looks like verses are comprised of:
  # - Intro
  # - descending count verses
  # - Ending

  def verse(verse_number = 1) do
    state =
      verse_number
      |> get_verse_data()
      |> build_intro()
      |> build_ending()

    Enum.join(state.output, ", ")
  end

  # When given a number other than 1, must return all of the verses until 1
  def verse(verse_number) do
    raise "NOOO"
    #build_verse(verse_number)
  end

  def build_intro(verse_data = %{}) do
    intro = "On the #{verse_data.ordinal} day of Christmas my true love gave to me"
    output = verse_data.output ++ [intro]
    Map.put(verse_data, :output, output)
  end

  def build_ending(verse_data = %{}) do
    ending = "#{verse_data.cardinal} #{verse_data.item}."
    output = verse_data.output ++ [ending]
    Map.put(verse_data, :output, output)
  end

  # no.
  def build_verse(verse_number) do
    verse_data =
      verse_number
      |> get_verse_data()
      |> Enum.at(0)
    "On the #{verse_data.ordinal} day of Christmas my true love gave to me, #{verse_data.cardinal} #{verse_data.item}."
  end

  # Add an and
  def build_last_item() do
    "and a Partridge in a Pear Tree"
  end

  def verse_list() do
    [
      %{verse_number: 1,  cardinal: "a", ordinal: "first", item: "Partridge in a Pear Tree"},
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
    verse_data = Enum.filter(verse_list, fn(el)-> el.verse_number == n end) |> Enum.at(0)
    Map.put(verse_data, :output, [])
  end
end
