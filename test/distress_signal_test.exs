defmodule AOC2022.DistressSignalTest do
  use ExUnit.Case, async: true

  alias AOC2022.Input
  alias AOC2022.DistressSignal

  test "returns the sum of the indexes of the pairs in the right order" do
    input = Input.read("distress_signal.txt")

    assert DistressSignal.solve(input, :part_1) == 5330
  end

  test "returns the product the divider packets" do
    input = Input.read("distress_signal.txt")

    assert DistressSignal.solve(input, :part_2) == 27648
  end
end
