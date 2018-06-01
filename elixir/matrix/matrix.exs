defmodule Matrix do
  defstruct(
    row_count: nil,
    rows: [],
    columns: []
  )

  def from_string(input) do
    create_matrix(input, %Matrix{})
  end

  def create_matrix(input, matrix) do
    rows =
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn row_string ->
        row_string
        |> String.split(" ", trim: true)
        |> Enum.map(fn cell ->
          {int, _} = Integer.parse(cell)
          int
        end)
      end)

    columns =
      rows
      |> Enum.with_index()
      |> Enum.map(fn row_with_index ->
        {row, index} = row_with_index
        Enum.reduce(rows, [], fn el, acc ->
          acc ++ [Enum.at(el, index)]
        end)
      end)

    matrix
    |> Map.put(:rows, rows)
    |> Map.put(:columns, columns)
  end

  def to_string(matrix = %Matrix{}) do
    matrix.rows
    |> Enum.reduce("", fn row, row_acc ->
      row_acc <> Enum.join(row, " ") <> "\n"
    end)
    |> String.trim("\n")
  end

  def row(matrix = %Matrix{}, index) do
    Enum.at(matrix.rows, index)
  end

  def rows(matrix) do
    matrix.rows
  end

  def columns(matrix) do
    matrix.columns
  end

  def column(matrix, index) do
    Enum.at(matrix.columns, index)
  end
end
