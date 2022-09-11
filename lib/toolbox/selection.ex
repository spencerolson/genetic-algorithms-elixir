defmodule Toolbox.Selection do
  def elite(population, _opts) do
    population
      |> Enum.chunk_every(2)
      |> Enum.map(&List.to_tuple(&1))
  end
end
