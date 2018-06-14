defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t(), integer) :: map
  def add(db = %{}, name, grade) do
    if Kernel.is_nil(db[grade]) do
      Map.put(db, grade, [name])
    else
      Map.put(db, grade, db[grade] ++ [name])
    end
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t()]
  def grade(db, grade) do
    Enum.reduce(db, [], fn el, acc ->
      {el_grade, students} = el

      if el_grade == grade do
        acc ++ students
      else
        acc
      end
    end)
  end

  @doc """
  Sorts the school by grade and name.

  I dislike this implementation, but this is what the tests suggest.
  I prefer working with maps but I guess the point of the exercise
  was to convert a map to list.
  """
  @spec sort(map) :: [{integer, [String.t()]}]
  def sort(db) do
    db
    |> Enum.reduce([], fn {k, v}, acc ->
        acc ++ [{k, Enum.sort(v)}]
      end)
  end
end
