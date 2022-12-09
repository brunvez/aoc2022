defmodule AOC2022.TreetopTreeHouseTest do
  use ExUnit.Case

  alias AOC2022.Input
  alias AOC2022.TreetopTreeHouse

  test "gets all visible trees in the field" do
    input = Input.read("treetop_tree_house.txt")

    assert 1538 == TreetopTreeHouse.solve(input, &TreetopTreeHouse.visible_trees/1)
  end

  test "gets the tree with the max view" do
    input = Input.read("treetop_tree_house.txt")

    assert 496_125 == TreetopTreeHouse.solve(input, &TreetopTreeHouse.maximum_view/1)
  end
end
