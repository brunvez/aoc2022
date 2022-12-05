defmodule AOC2022.RockPaperScissorsTest do
  use ExUnit.Case

  alias AOC2022.Input
  alias AOC2022.RockPaperScissors

  test "calculates the hypothetical game score given the shape to choose" do
    input = Input.read("rock_paper_scissors.txt")
    assert RockPaperScissors.solve(input, &RockPaperScissors.given_shape_converter/1) == 10941
  end

  test "calculates the hypothetical game score given the outcome to get" do
    input = Input.read("rock_paper_scissors.txt")
    assert RockPaperScissors.solve(input, &RockPaperScissors.given_outcome_converter/1) == 13071
  end
end
