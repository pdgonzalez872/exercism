defmodule Tournament do
  defmodule Team do
    defstruct(
      name: nil,
      matches_played: nil,
      wins: nil,
      draws: nil,
      losses: nil,
      points: nil
    )
  end

  defmodule Match do
    defstruct(
      home_team: nil,
      away_team: nil,
      home_team_result: nil,
      away_team_result: nil,
      home_team_points: nil,
      away_team_points: nil,
      raw_match_result: nil
    )
  end

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    # input
    # |> Enum.map(fn match -> process_match(match) end)
    # |> display_output()
  end

  def process_match(input) do
    result =
      input
      |> String.split(";", trim: true)
      |> Enum.map(fn match ->
        match
        |> create_match()
        |> score_match()
      end)

    require IEx
    IEx.pry()
  end

  @doc ~S"""
  Scores a match based on input

  ## Examples
    iex> Tournament.create_match(["Allegoric Alaskans", "Blithering Badgers", "win"])
    %Tournament.Match{home_team: "Allegoric Alaskans", away_team: "Blithering Badgers", home_team_result: :win, away_team_result: :loss, raw_match_result: "win", home_team_points: 3, away_team_points: 0}

    iex> Tournament.create_match(["Allegoric Alaskans", "Blithering Badgers", "loss"])
    %Tournament.Match{home_team: "Allegoric Alaskans", away_team: "Blithering Badgers", home_team_result: :loss, away_team_result: :win, raw_match_result: "loss", home_team_points: 0, away_team_points: 3}
  """
  def create_match(input) do
    [home_team, away_team, raw_match_result] = input

    %Match{home_team: home_team, away_team: away_team, raw_match_result: raw_match_result}
    |> score_match()
  end

  @doc ~S"""
  Scores a match based on input
  """
  def score_match(match = %Match{raw_match_result: "win"}) do
    match
    |> Map.put(:home_team_result, :win)
    |> Map.put(:away_team_result, :loss)
    |> Map.put(:home_team_points, 3)
    |> Map.put(:away_team_points, 0)
  end

  def score_match(match = %Match{raw_match_result: "loss"}) do
    match
    |> Map.put(:home_team_result, :loss)
    |> Map.put(:away_team_result, :win)
    |> Map.put(:home_team_points, 0)
    |> Map.put(:away_team_points, 3)
  end
end
