defmodule Speller do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = Stream.repeatedly(fn -> Enum.random(?a..?z) end)
      |> Enum.take(34)

    %Chromosome{genes: genes, size: 34}
  end

  @impl true
  def fitness_function(chromosome) do
    target = "supercalifragilisticexpialidocious"
    guess = List.to_string(chromosome.genes)
    String.jaro_distance(target, guess)
  end

  @impl true
  def terminate?(_population, _generation, temperature) do
    temperature < 0.01
  end
end

solution = Genetic.run(Speller, population_size: 1000)
IO.write("\n")
IO.inspect(solution)

