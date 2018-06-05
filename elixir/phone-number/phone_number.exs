defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("212-555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 555-0100")
  "2125550100"

  iex> Phone.number("+1 (212) 055-0100")
  "0000000000"

  iex> Phone.number("(212) 555-0100")
  "2125550100"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @spec number(String.t()) :: String.t()
  def number(input) do
    result = process_number(input)
    result.simple_display
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("212-555-0100")
  "212"

  iex> Phone.area_code("+1 (212) 555-0100")
  "212"

  iex> Phone.area_code("+1 (012) 555-0100")
  "000"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t()) :: String.t()
  def area_code(input) do
    result = process_number(input)
    result.area_code
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("212-555-0100")
  "(212) 555-0100"

  iex> Phone.pretty("212-155-0100")
  "(000) 000-0000"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t()) :: String.t()
  def pretty(input) do
    result = process_number(input)
    result.pretty_digits
  end

  defp process_number(input) do
    input
    |> prepare_number()
    |> create_number()
  end

  defp prepare_number(input) do
    if valid?(input) do
      {:ok, input}
    else
      {:error, input}
    end
  end

  defp valid?(input) do
    !invalid?(input)
  end

  defp invalid?(input) do
    digits = Regex.scan(~r/\d/, input)

    contains_letters(input) || invalid_length(digits) || invalid_country(digits) ||
      invalid_area_code(digits) || invalid_exchange_code(digits)
  end

  defp contains_letters(input) do
    letters = Regex.scan(~r/[a-zA-Z]/, input)
    !Enum.empty?(letters)
  end

  defp invalid_length(digits) do
    Enum.count(digits) <= 9
  end

  defp invalid_country(digits) do
    Enum.count(digits) == 11 && Enum.at(digits, 0) != ["1"]
  end

  defp invalid_area_code(digits) do
    (Enum.count(digits) == 10 && Enum.at(digits, 0) == ["1"]) || Enum.at(digits, 0) == ["0"]
  end

  defp invalid_exchange_code(digits) do
    [_, _, _, exchange_code | _tail] = digits
    (Enum.count(digits) == 10 && exchange_code == ["1"]) || exchange_code == ["0"]
  end

  defp create_number({:error, _}) do
    %{simple_display: "0000000000", area_code: "000", pretty_digits: "(000) 000-0000"}
  end

  defp create_number({:ok, input}) do
    digits = Regex.scan(~r/\d/, input)

    %{input: input, digits: digits}
    |> add_country_code()
    |> add_area_code()
    |> add_remaining_digits()
    |> add_simple_display()
    |> add_pretty_digits
  end

  defp add_country_code(state) do
    Map.put(state, :country_code, "1")
  end

  defp add_area_code(state) do
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

  defp add_remaining_digits(state) do
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

  defp add_simple_display(state) do
    simple_display = state.area_code <> state.remaining_digits
    Map.put(state, :simple_display, simple_display)
  end

  defp add_pretty_digits(state) do
    split_remaining = String.split(state.remaining_digits, "", trim: true)
    a = split_remaining |> Enum.take(3) |> Enum.join("")
    b = split_remaining |> Enum.take(-4) |> Enum.join("")

    Map.put(state, :pretty_digits, "(#{state.area_code}) #{a}-#{b}")
  end

end
