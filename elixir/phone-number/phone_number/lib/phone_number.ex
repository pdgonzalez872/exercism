defmodule Phone do
  defstruct(
    input: nil,
    digits: nil,
    country_code: nil,
    area_code: nil,
    remaining_digits: nil,
    full_number: nil,
    pretty_digits: nil,
    simple_display: nil
  )

  def number(input) do
    result = process_number(input)
    result.simple_display
  end

  def area_code(input) do
    result = process_number(input)
    result.area_code
  end

  def pretty(input) do
    result = process_number(input)
    result.pretty_digits
  end

  def process_number(input) do
    input
    |> prepare_number()
    |> create_number()
  end

  def prepare_number(input) do
    if valid?(input) do
      {:ok, input}
    else
      {:error, input}
    end
  end

  def valid?(input) do
    !invalid?(input)
  end

  def invalid?(input) do
    digits = Regex.scan(~r/\d/, input)

    contains_letters(input) || invalid_length(digits) || invalid_country(digits) ||
      invalid_area_code(digits) || invalid_exchange_code(digits)
  end

  def contains_letters(input) do
    letters = Regex.scan(~r/[a-zA-Z]/, input)
    !Enum.empty?(letters)
  end

  def invalid_length(digits) do
    Enum.count(digits) <= 9
  end

  def invalid_country(digits) do
    Enum.count(digits) == 11 && Enum.at(digits, 0) != ["1"]
  end

  def invalid_area_code(digits) do
    (Enum.count(digits) == 10 && Enum.at(digits, 0) == ["1"]) || Enum.at(digits, 0) == ["0"]
  end

  def invalid_exchange_code(digits) do
    [_, _, _, exchange_code | _tail] = digits
    (Enum.count(digits) == 10 && exchange_code == ["1"]) || exchange_code == ["0"]
  end

  def create_number({:error, _}) do
    %{simple_display: "0000000000", area_code: "000", pretty_digits: "(000) 000-0000"}
  end

  def create_number({:ok, input}) do
    digits = Regex.scan(~r/\d/, input)

    %Phone{input: input, digits: digits}
    |> add_country_code()
    |> add_area_code()
    |> add_remaining_digits()
    |> add_simple_display()
    |> add_pretty_digits
  end

  def add_country_code(state) do
    Map.put(state, :country_code, "1")
  end

  def add_area_code(state) do
    area_code =
      cond do
        Enum.count(state.digits) == 10 ->
          [a, b, c | _tail] = state.digits
          "#{a}#{b}#{c}"

        Enum.count(state.digits) == 11 ->
          [_a, b, c, d | _tail] = state.digits
          "#{b}#{c}#{d}"

        true ->
          ""
      end

    Map.put(state, :area_code, area_code)
  end

  def add_remaining_digits(state) do
    target_index =
      if Enum.count(state.digits) == 11 do
        3
      else
        2
      end

    remaining_digits =
      state.digits
      |> Enum.with_index()
      |> Enum.filter(fn {_e, index} -> index > target_index end)
      |> Enum.map(fn el ->
        {e, _index} = el
        e
      end)
      |> Enum.join("")

    Map.put(state, :remaining_digits, remaining_digits)
  end

  def add_simple_display(state) do
    simple_display = state.area_code <> state.remaining_digits
    Map.put(state, :simple_display, simple_display)
  end

  def add_pretty_digits(state) do
    split_remaining = String.split(state.remaining_digits, "", trim: true)
    a = Enum.take(split_remaining, 3) |> Enum.join("")
    b = Enum.take(split_remaining, -4) |> Enum.join("")

    Map.put(state, :pretty_digits, "(#{state.area_code}) #{a}-#{b}")
  end
end
