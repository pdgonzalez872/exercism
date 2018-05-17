defmodule SpaceAge do

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
        days_in_year: 365.25
      }
    ]
  )

  def age_on(planet = :earth, seconds) do

    # seconds
    # minutes
    # hours
    # days
    # years

    (seconds / 1)
    |> to_minutes()
    |> to_hours()
    |> to_days(planet)
    |> to_years(planet)
  end

  def divide_by_60(input), do: input / 60

  def to_minutes(input), do: divide_by_60(input)
  def to_hours(input), do: divide_by_60(input)

  def to_days(input, planet = :earth) do
    planet_data = @planet_data[planet]
    input / planet_data.hours_in_days
  end

  def to_years(input, :earth) do
    input / 365.25
  end
end
