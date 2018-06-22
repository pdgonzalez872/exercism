defmodule Garden do
  @students(%{
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
  })

  @mapping(%{
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
      23 => :larry,
    }
  )

  def info(input) do
    input
    |> create_data_structure()
  end

  def create_data_structure(input) do
    [row_1, row_2] = String.split(input, "\n", trim: true)

    plantings_1 = String.split(row_1, "", trim: true)
    plantings_2 = String.split(row_2, "", trim: true)

    # shameless green
    plantings = %{"C" => :clover, "G" => :grass, "R" => :radishes, "V" => :violets}

    translated_1 = plantings_1 |> translate_planting()
    translated_2 = plantings_2 |> translate_planting()

    result_1 = allocate_to_person(@students, translated_1, @mapping)
    result_2 = allocate_to_person(@students, translated_2, @mapping)

    final = Map.merge(result_1, result_2, fn _k, v1, v2 -> v1 ++ v2 end)
    require IEx; IEx.pry()
  end

  def allocate_to_person(students, plant_list, mapping) do
    result = plant_list
    |> Enum.with_index()
    |> Enum.reduce(students, fn {el, i}, acc ->
      person = mapping[i]
      old = case Map.fetch(acc, person) do
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
    plantings = %{"C" => :clover, "G" => :grass, "R" => :radishes, "V" => :violets}
    plantings[plant]
  end
end
