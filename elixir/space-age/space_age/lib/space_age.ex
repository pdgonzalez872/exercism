defmodule SpaceAge do

  defstruct(seconds_in_minute: 60, minutes_in_hour: 60, hours_in_days: 24, days_in_year: nil)

  @planet_data(
    [
      earth: %{
        seconds_in_minute: 60,
        minutes_in_hour: 60,
        hours_in_days: 24,
        days_in_year: 365.25
      },

      mercury: %{
        seconds_in_minute: 60,
        minutes_in_hour: 60,
        hours_in_days: 24,
        days_in_year: 87.97
      },

      mars: %{
        seconds_in_minute: 60,
        minutes_in_hour: 60,
        hours_in_days: 24,
        days_in_year: 687.0
      },

      venus: %{
        seconds_in_minute: 60,
        minutes_in_hour: 60,
        hours_in_days: 24,
        days_in_year: 224.70
      }
    ]
  )

  def age_on(planet, seconds) do
    seconds
    #|> to_float()
    |> to_minutes()
    |> to_hours()
    |> to_days(planet)
    |> to_years(planet)
  end

  def to_float(input), do: input / 1

  def divide_by_60(input), do: input / 60
  def to_minutes(input), do: divide_by_60(input)
  def to_hours(input), do: divide_by_60(input)

  def to_days(input, planet) do
    planet_data = @planet_data[planet]
    input / planet_data.hours_in_days
  end

  def to_years(input, planet) do
    planet_data = @planet_data[planet]
    input / planet_data.days_in_year
  end
end
