defmodule AOC2022.NoSpaceLeftTest do
  use ExUnit.Case, async: true

  alias AOC2022.Input
  alias AOC2022.NoSpaceLeft

  test "finds the sum of directories with size <= 100_000" do
    input = Input.read("no_space_left.txt")

    assert 1_770_595 =
             NoSpaceLeft.solve(input, NoSpaceLeft.sum_small_directories(max_size: 100_000))
  end

  test "finds the smallest directory with size >= 3_000_000" do
    input = Input.read("no_space_left.txt")

    assert 2_195_372 = NoSpaceLeft.solve(input, NoSpaceLeft.free_space(needed_space: 30_000_000))
  end
end
