defmodule Cargo do
  @behaviour Problem
  alias Types.Chromosome

  @impl true
  def genotype do
    genes = for _ <- 1..10, do: Enum.random(0..1)
    %Chromosome{genes: genes, size: length(genes)}
  end

  @impl true
  def fitness_function(chromosome) do
    profits = [6, 5, 8, 9, 6, 7, 3, 1, 2, 6]
    weights = [10, 6, 8, 7, 10, 9, 7, 11, 6, 8]
    weight_limit = 40

    potential_profits =
      profits
      |> Enum.zip(chromosome.genes)
      |> Enum.map(fn {profit, on_off} -> profit * on_off end)
      |> Enum.sum()

    over_limit? =
      weights
      |> Enum.zip(chromosome.genes)
      |> Enum.map(fn {weight, on_off} -> weight * on_off end)
      |> Enum.sum()
      |> Kernel.>(weight_limit)

    profits = if over_limit?, do: 0, else: potential_profits
    profits
  end

  @impl true
  def terminate?(_population, generation), do: generation == 100
end

solution = Genetic.run(Cargo, population_size: 50)
IO.write("\n")
IO.inspect(solution)

weight =
solution.genes
|> Enum.zip([10, 6, 8, 7, 10, 9, 7, 11, 6, 8])
|> Enum.map(fn {on_off, weight} -> weight * on_off end)
|> Enum.sum()

IO.write("\nWeight is: #{weight}\n")
