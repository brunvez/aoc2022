defmodule AOC2022.MonkeyInTheMiddleTest do
  use ExUnit.Case, async: true

  alias AOC2022.Input
  alias AOC2022.MonkeyInTheMiddle

  test "returns the level of monkey businesses after 20 rounds" do
    input = Input.read("monkey_in_the_middle.txt")

    assert MonkeyInTheMiddle.solve(input, worry_divisor: 3, rounds: 20) == 118_674
  end

  test "returns the level of monkey businesses after 10_000 rounds with no worry divisor" do
    input = Input.read("monkey_in_the_middle.txt")

    assert MonkeyInTheMiddle.solve(input, worry_divisor: 1, rounds: 10_000) == 32_333_418_600
  end
end
