defmodule AOC2022.RucksackReorganizationTest do
  use ExUnit.Case

  alias AOC2022.Input
  alias AOC2022.RucksackReorganization

  test "calculates the priority of repeated items in different compartments" do
    input = Input.read("rucksack_reorganization.txt")

    assert RucksackReorganization.solve(input, &RucksackReorganization.compartments_splitter/1) ==
             7701
  end

  test "calculates the priority of repeated items in different groups" do
    input = Input.read("rucksack_reorganization.txt")

    assert RucksackReorganization.solve(input, &RucksackReorganization.group_splitter/1) == 2644
  end
end
