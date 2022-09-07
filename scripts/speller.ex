defmodule Speller do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = Stream.repeatedly(fn -> Enum.random(?a..?z) end)
      |> Enum.take(6)

    %Chromosome{genes: genes, size: 6}
  end

  @impl true
  def fitness_function(chromosome) do
    target = "sekrit"
    guess = List.to_string(chromosome.genes)
    String.jaro_distance(target, guess)
  end

  @impl true
  def terminate?([best | _]), do: best.fitness == 1
end

solution = Genetic.run(Speller)
IO.write("\n")
IO.inspect(solution)

