defmodule SpaceAge do
  # How many (Earth scale) days in a year.
  @planet_data [
    earth: %{
      days_in_year: 365.25
    },
    mercury: %{
      days_in_year: 87.97
    },
    mars: %{
      days_in_year: 687.0
    },
    venus: %{
      days_in_year: 224.70
    },
    jupiter: %{
      days_in_year: 4340
    },
    saturn: %{
      days_in_year: 10_750
    },
    uranus: %{
      days_in_year: 30_750
    },
    neptune: %{
      days_in_year: 59_955
    },
  ]

  def age_on(planet, seconds) do
    seconds
    |> to_minutes()
    |> to_hours()
    |> to_days(planet)
    |> to_years(planet)
  end

  def to_float(input), do: input / 1

  def divide_by_60(input), do: input / 60
  def to_minutes(input), do: divide_by_60(input)
  def to_hours(input), do: divide_by_60(input)

  def to_days(input, _planet) do
    input / 24
  end

  def to_years(input, planet) do
    planet_data = @planet_data[planet]
    input / planet_data.days_in_year
  end
end
