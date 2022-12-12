defmodule AOC2022.RopeBridgeTest do
  use ExUnit.Case, async: true

  alias AOC2022.Input
  alias AOC2022.RopeBridge

  test "returns the unique positions of the tail after completing the moves with one knot" do
    input = Input.read("rope_bridge.txt")
    assert RopeBridge.solve(input, knots: [{0, 0}, {0, 0}]) == 6314
  end

  test "returns the unique positions of the tail after completing the moves with nine knot" do
    input = Input.read("rope_bridge.txt")

    assert RopeBridge.solve(input,
             knots: [
               {0, 0},
               {0, 0},
               {0, 0},
               {0, 0},
               {0, 0},
               {0, 0},
               {0, 0},
               {0, 0},
               {0, 0},
               {0, 0}
             ]
           ) == 2504
  end
end
