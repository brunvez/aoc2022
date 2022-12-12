defmodule AOC2022.CampCleanupTest do
  use ExUnit.Case, async: true

  alias AOC2022.Input
  alias AOC2022.CampCleanup

  test "calculates the number of overlapping pairs" do
    input = Input.read("camp_cleanup.txt")

    assert CampCleanup.solve(input, &CampCleanup.cointained?/1) == 582
  end

  test "calculates the number of joined pairs" do
    input = Input.read("camp_cleanup.txt")

    assert CampCleanup.solve(input, &CampCleanup.overlapping?/1) == 893
  end
end
