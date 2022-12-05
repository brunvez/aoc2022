defmodule AOC2022.SupplyStacksTest do
  use ExUnit.Case

  alias AOC2022.Input
  alias AOC2022.SupplyStacks

  test "returns the crates at the top of the stack moving them one by one" do
    input = Input.read("supply_stack.txt")
    assert SupplyStacks.solve(input, &SupplyStacks.move_individually/2) == "CFFHVVHNC"
  end

  test "returns the crates at the top of the stack moving them in groups" do
    input = Input.read("supply_stack.txt")
    assert SupplyStacks.solve(input, &SupplyStacks.move_groupally/2) == "FSZWBPTBG"
  end
end
