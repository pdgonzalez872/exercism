defmodule Garden do
  @moduledoc ~S"""
  I don't like how the return type is a dynamic tuple.
  """

  @default_students [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]

  @students %{
    alice: [],
    bob: [],
    charlie: [],
    david: [],
    eve: [],
    fred: [],
    ginny: [],
    harriet: [],
    ileana: [],
    joseph: [],
    kincaid: [],
    larry: []
  }

  @mapping %{
    0 => :alice,
    1 => :alice,
    2 => :bob,
    3 => :bob,
    4 => :charlie,
    5 => :charlie,
    6 => :david,
    7 => :david,
    8 => :eve,
    9 => :eve,
    10 => :fred,
    11 => :fred,
    12 => :ginny,
    13 => :ginny,
    14 => :harriet,
    15 => :harriet,
    16 => :ileana,
    17 => :ileana,
    18 => :joseph,
    19 => :joseph,
    20 => :kincaid,
    21 => :kincaid,
    22 => :larry,
    23 => :larry
  }

  @plant_translations %{"C" => :clover, "G" => :grass, "R" => :radishes, "V" => :violets}

  def info(input) do
    input
    |> create_plantings()
    |> translate_plantings()
    |> allocate_to_people(@students, @mapping)
    |> prepare_output()
  end

  @doc ~S"""
  Custom names, nice
  """
  def info(input, names) do

    people = create_people(names)
    mappings = create_mappings(names)

    result = input
    |> create_plantings()
    |> translate_plantings()
    |> allocate_to_people(people, mappings)
    |> prepare_output()
  end

  def debug(input) do
    require IEx; IEx.pry
  end

  @doc ~S"""
  ## Examples:
    iex> Garden.create_people([:nate, :maggie])
    %{nate: [], maggie: []}
  """
  def create_people(names) do
    Enum.reduce(names, %{}, fn el, acc -> Map.put(acc, el, []) end)
  end

  @doc ~S"""
  ## Examples:
    iex> Garden.create_mappings([:nate, :maggie])
    %{0 => :nate, 1 => :nate, 2 => :maggie, 3 => :maggie}
  """
  def create_mappings(names) do
    names
    |> Enum.reduce([], fn el, acc -> acc ++ [el]  ++ [el] end)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {el, i}, acc ->
      Map.put(acc, i, el)
    end)
  end

  def create_plantings(input) when is_binary(input) do
    [row_1, row_2] = String.split(input, "\n", trim: true)
    {String.split(row_1, "", trim: true), String.split(row_2, "", trim: true)}
  end

  def translate_plantings({p1, p2}) do
    {translate_planting(p1), translate_planting(p2)}
  end

  def allocate_to_people({p1, p2}, people, mapping) do
    result1 = allocate_to_person(people, p1, mapping)
    result2 = allocate_to_person(people, p2, mapping)
    {result1, result2}
  end

  def prepare_output({p1, p2}) do
    Map.merge(p1, p2, fn _k, v1, v2 -> v1 ++ v2 end)
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      Map.put(acc, k, List.to_tuple(v))
    end)
  end

  def allocate_to_person(students, plant_list, mapping) do
    result =
      plant_list
      |> Enum.with_index()
      |> Enum.reduce(students, fn {el, i}, acc ->
        person = mapping[i]

        old =
          case Map.fetch(acc, person) do
            {:ok, old} ->
              old

            {:error} ->
              []
          end

        Map.put(acc, person, old ++ [el])
      end)
  end

  def translate_planting(planting) do
    Enum.map(planting, fn el -> translate_plant_type(el) end)
  end

  def translate_plant_type(plant) do
    @plant_translations[plant]
  end
end
