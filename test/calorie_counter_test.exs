defmodule AOC2022.CalorieCounterTest do
  use ExUnit.Case, async: true

  alias AOC2022.CalorieCounter
  alias AOC2022.Input

  test "finds the top highest calorie" do
    input = Input.read("calories.txt")
    assert CalorieCounter.solve(input, top: 1) == 75501
  end

  test "finds the top 3 highest calories" do
    input = Input.read("calories.txt")
    assert CalorieCounter.solve(input, top: 3) == 215_594
  end
end
