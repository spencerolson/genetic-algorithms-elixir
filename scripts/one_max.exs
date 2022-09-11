defmodule OneMax do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..100, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: 100}
  end

  @impl true
  def fitness_function(chromosome), do: Enum.sum(chromosome.genes)

  @impl true
  def terminate?(_population, _generation, temperature) do
    temperature < 1
  end
end

solution = Genetic.run(OneMax, population_size: 1000)
IO.write("\n")
IO.inspect(solution)
