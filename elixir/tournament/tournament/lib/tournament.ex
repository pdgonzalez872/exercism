defmodule Tournament do
  defmodule Summary do
    defstruct(
      name: nil,
      matches_played: 0,
      wins: 0,
      draws: 0,
      losses: 0,
      points: 0
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
    result =
      input
      |> create_matches()
      |> Enum.map(fn match -> create_team_results(match) end)
      |> List.flatten()
      |> calculate_results()
      # |> display_results()

    # require IEx; IEx.pry()
  end

  @doc ~S"""
  Creates matches based on the list input

  ## Examples
    iex> Tournament.create_matches(["Allegoric Alaskans;Blithering Badgers;win", "Devastating Donkeys;Courageous Californians;draw"])
    [
      %Tournament.Match{
        away_team: "Blithering Badgers",
        away_team_points: 0,
        away_team_result: :loss,
        home_team: "Allegoric Alaskans",
        home_team_points: 3,
        home_team_result: :win,
        raw_match_result: "win"
      },
      %Tournament.Match{
        away_team: "Courageous Californians",
        away_team_points: 1,
        away_team_result: :draw,
        home_team: "Devastating Donkeys",
        home_team_points: 1,
        home_team_result: :draw,
        raw_match_result: "draw"
      }
    ]
  """
  def create_matches(input) do
    input
    |> Enum.map(fn match ->
      match
      |> String.split(";", trim: true)
      |> create_match()
      |> score_match()
    end)
  end

  @doc ~S"""
  Scores a match based on input

  ## Examples
    iex> Tournament.create_match(["Allegoric Alaskans", "Blithering Badgers", "win"])
    %Tournament.Match{home_team: "Allegoric Alaskans", away_team: "Blithering Badgers", home_team_result: :win, away_team_result: :loss, raw_match_result: "win", home_team_points: 3, away_team_points: 0}

    iex> Tournament.create_match(["Allegoric Alaskans", "Blithering Badgers", "loss"])
    %Tournament.Match{home_team: "Allegoric Alaskans", away_team: "Blithering Badgers", home_team_result: :loss, away_team_result: :win, raw_match_result: "loss", home_team_points: 0, away_team_points: 3}

    iex> Tournament.create_match(["Allegoric Alaskans", "Blithering Badgers", "draw"])
    %Tournament.Match{home_team: "Allegoric Alaskans", away_team: "Blithering Badgers", home_team_result: :draw, away_team_result: :draw, raw_match_result: "draw", home_team_points: 1, away_team_points: 1}
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

  def score_match(match = %Match{raw_match_result: "draw"}) do
    match
    |> Map.put(:home_team_result, :draw)
    |> Map.put(:away_team_result, :draw)
    |> Map.put(:home_team_points, 1)
    |> Map.put(:away_team_points, 1)
  end

  @doc ~S"""
  Creates team results from a match

  ## Examples

    iex> Tournament.create_team_results(%Tournament.Match{home_team: "Allegoric Alaskans", away_team: "Blithering Badgers", home_team_result: :draw, away_team_result: :draw, raw_match_result: "draw", home_team_points: 1, away_team_points: 1})
    [%{team_name: "Allegoric Alaskans", result: :draw, points: 1}, %{team_name: "Blithering Badgers", result: :draw, points: 1}]
  """
  def create_team_results(match = %Match{}) do
    [
      %{team_name: match.home_team, result: match.home_team_result, points: match.home_team_points},
      %{team_name: match.away_team, result: match.away_team_result, points: match.away_team_points},
    ]
  end

  def calculate_results(team_results) do
    result =
      team_results
      |> Enum.group_by(fn tr -> tr.team_name end)
      |> Enum.reduce("", fn group, group_acc ->
        {team_name, results} = group
        summary = Enum.reduce(results, %Summary{name: team_name}, fn r, acc ->
          update_result(acc, r)
        end)

        group_acc <> create_team_output(summary) <> "\n"
      end)

    "Team                           | MP |  W |  D |  L |  P\n" <> result
  end

  def update_result(result = %Summary{}, %{result: :win}) do
    result
    |> Map.put(:wins, result.wins + 1)
    |> Map.put(:points, result.points + 3)
    |> Map.put(:matches_played, result.matches_played + 1)
  end

  def update_result(result = %Summary{}, %{result: :loss}) do
    result
    |> Map.put(:losses, result.losses + 1)
    |> Map.put(:points, result.points + 0)
    |> Map.put(:matches_played, result.matches_played + 1)
  end

  def update_result(result = %Summary{}, %{result: :draw}) do
    result
    |> Map.put(:draws, result.draws + 1)
    |> Map.put(:points, result.points + 1)
    |> Map.put(:matches_played, result.matches_played + 1)
  end

  @doc ~S"""
  Creates a string output from a map.

  Should look like:
  Team                           | MP |  W |  D |  L |  P
  Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6

  ## Examples

    iex> Tournament.create_team_output(%Tournament.Summary{draws: 0, losses: 1, matches_played: 3, name: "Allegoric Alaskans", points: 6, wins: 2})
    "Allegoric Alaskans             |  3 |  2 |  0 |  1 |  6"
  """
  def create_team_output(summary = %Summary{}) do
    pad_amount = 3
    []
    |> List.insert_at(-1, "#{String.pad_trailing(summary.name, 30)}")
    |> List.insert_at(-1, String.pad_leading("#{summary.matches_played}", pad_amount))
    |> List.insert_at(-1, String.pad_leading("#{summary.wins}", pad_amount))
    |> List.insert_at(-1, String.pad_leading("#{summary.draws}", pad_amount))
    |> List.insert_at(-1, String.pad_leading("#{summary.losses}", pad_amount))
    |> List.insert_at(-1, String.pad_leading("#{summary.points}", pad_amount))
    |> Enum.join(" |")
  end
end
