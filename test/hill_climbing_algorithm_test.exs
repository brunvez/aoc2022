defmodule AOC2022.HillClimbingAlgorithmTest do
  use ExUnit.Case, async: true

  alias AOC2022.Input
  alias AOC2022.HillClimbingAlgorithm

  test "returns the fewest steps to get the best signal starting from the original starting point" do
    input = Input.read("hill_climbing_algorithm.txt")

    assert HillClimbingAlgorithm.solve(input, &HillClimbingAlgorithm.original_start/2) == 440
  end

  test "returns the fewest steps to get the best signal starting from the any a" do
    input = Input.read("hill_climbing_algorithm.txt")

    assert HillClimbingAlgorithm.solve(input, &HillClimbingAlgorithm.every_a/2) == 439
  end
end
