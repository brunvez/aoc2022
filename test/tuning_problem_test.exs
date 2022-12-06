defmodule AOC2022.TuningProblemTest do
  use ExUnit.Case

  alias AOC2022.Input
  alias AOC2022.TuningProblem

  test "returns the time of first marker" do
    input = Input.read("tuning_problem.txt")

    assert TuningProblem.solve(input, marker_length: 4) == 1953
  end

  test "returns the time of first message" do
    input = Input.read("tuning_problem.txt")

    assert TuningProblem.solve(input, marker_length: 14) == 2301
  end
end
