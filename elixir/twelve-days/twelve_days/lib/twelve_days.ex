defmodule TwelveDays do

  def sing() do
    verses(1, 12)
  end

  def verses(start_range, end_range) do
    Enum.map(end_range..start_range, fn(verse_number)-> verse(verse_number) end)
    |> Enum.reverse()
    |> Enum.join("\n")
  end

  def verse(verse_number = 1) do
    state =
      verse_number
      |> get_verse_data()
      |> build_intro()
      |> build_ending()

    Enum.join(state.output, ", ")
  end

  def verse(verse_number) do
    state =
      verse_number
      |> get_verse_data()
      |> build_intro()
      |> build_middle_verses()
      |> build_ending()

    Enum.join(state.output, ", ")
  end

  def build_intro(state = %{}) do
    intro = "On the #{state.ordinal} day of Christmas my true love gave to me"
    output = state.output ++ [intro]
    Map.put(state, :output, output)
  end

  def build_ending(state = %{}) do
    ending =
      cond do
        state.verse_number == 1 ->
          "#{state.cardinal} #{state.item}."
        true ->
          verse_data = get_verse_data(1)
          "and #{verse_data.cardinal} #{verse_data.item}."
      end

    output = state.output ++ [ending]
    Map.put(state, :output, output)
  end

  def build_middle_verses(state = %{}) do
    middle = Enum.map(state.verse_number..2, fn(verse_number)->
      verse_data = get_verse_data(verse_number)
      "#{verse_data.cardinal} #{verse_data.item}"
    end)

    output = state.output ++ middle
    Map.put(state, :output, output)
  end

  def get_verse_data(n) do
    state = Enum.filter(verse_list, fn(el)-> el.verse_number == n end) |> Enum.at(0)
    Map.put(state, :output, [])
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
      %{verse_number: 11, cardinal: "eleven", ordinal: "eleventh", item: "Pipers Piping"},
      %{verse_number: 12, cardinal: "twelve", ordinal: "twelfth", item: "Drummers Drumming"},
    ]
  end
end
