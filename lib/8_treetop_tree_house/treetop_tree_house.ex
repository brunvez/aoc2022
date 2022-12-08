defmodule AOC2022.TreetopTreeHouse do
  @moduledoc """
  --- Day 8: Treetop Tree House ---
  The expedition comes across a peculiar patch of tall trees all planted carefully in a grid.
  The Elves explain that a previous expedition planted these trees as a reforestation effort.
  Now, they're curious if this would be a good location for a tree house.

  First, determine whether there is enough tree cover here to keep a tree house hidden.
  To do this, you need to count the number of trees that are visible from outside the grid
  when looking directly along a row or column.

  The Elves have already launched a quadcopter to generate a map with the height of each tree (your puzzle input). For example:

  30373
  25512
  65332
  33549
  35390
  Each tree is represented as a single digit whose value is its height, where 0 is the shortest and 9 is the tallest.

  A tree is visible if all of the other trees between it and an edge of the grid are shorter than it.
  Only consider trees in the same row or column; that is, only look up, down, left, or right from any given tree.

  All of the trees around the edge of the grid are visible - since they are already on the edge, there are no trees to block the view.
  In this example, that only leaves the interior nine trees to consider:

  The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom since other trees of height 5 are in the way.)
  The top-middle 5 is visible from the top and right.
  The top-right 1 is not visible from any direction; for it to be visible, there would need to only be trees of height 0 between it and an edge.
  The left-middle 5 is visible, but only from the right.
  The center 3 is not visible from any direction; for it to be visible, there would need to be only trees of at most height 2 between it and an edge.
  The right-middle 3 is visible from the right.
  In the bottom row, the middle 5 is visible, but the 3 and 4 are not.
  With 16 trees visible on the edge and another 5 visible in the interior, a total of 21 trees are visible in this arrangement.

  Consider your map; how many trees are visible from outside the grid?

  --- Part Two ---
  Content with the amount of tree cover available, the Elves just need to know the best spot to build their tree house: they would like to be able to see a lot of trees.

  To measure the viewing distance from a given tree, look up, down, left, and right from that tree; stop if you reach an edge or at the first tree that is the same height
  or taller than the tree under consideration. (If a tree is right on the edge, at least one of its viewing distances will be zero.)

  The Elves don't care about distant trees taller than those found by the rules above; the proposed tree house has large eaves to keep it dry,
  so they wouldn't be able to see higher than the tree house anyway.

  In the example above, consider the middle 5 in the second row:

  30373
  25512
  65332
  33549
  35390
  Looking up, its view is not blocked; it can see 1 tree (of height 3).
  Looking left, its view is blocked immediately; it can see only 1 tree (of height 5, right next to it).
  Looking right, its view is not blocked; it can see 2 trees.
  Looking down, its view is blocked eventually; it can see 2 trees (one of height 3, then the tree of height 5 that blocks its view).
  A tree's scenic score is found by multiplying together its viewing distance in each of the four directions. For this tree, this is 4 (found by multiplying 1 * 1 * 2 * 2).

  However, you can do even better: consider the tree of height 5 in the middle of the fourth row:

  30373
  25512
  65332
  33549
  35390
  Looking up, its view is blocked at 2 trees (by another tree with a height of 5).
  Looking left, its view is not blocked; it can see 2 trees.
  Looking down, its view is also not blocked; it can see 1 tree.
  Looking right, its view is blocked at 2 trees (by a massive tree of height 9).
  This tree's scenic score is 8 (2 * 2 * 1 * 2); this is the ideal spot for the tree house.

  Consider each tree on your map. What is the highest scenic score possible for any tree?
  """

  defmodule Tree do
    defstruct [:height, :x, :y]
  end

  def solve(input, process) do
    input
    |> parse()
    |> locate_trees()
    |> process.()
  end

  def visible_trees(field) do
    acc =
      Enum.reduce(field, MapSet.new(), fn row, acc ->
        acc
        |> MapSet.union(visible_trees_in_row(row))
        |> MapSet.union(visible_trees_in_row(Enum.reverse(row)))
      end)

    field
    |> transpose()
    |> Enum.reduce(acc, fn row, acc ->
      acc
      |> MapSet.union(visible_trees_in_row(row))
      |> MapSet.union(visible_trees_in_row(Enum.reverse(row)))
    end)
    |> Enum.count()
  end

  def maximum_view(field) do
    acc = Enum.reduce(field, %{}, fn row, views ->
      views
      |> Map.merge(row_views(row), fn _k, a, b -> a * b end)
      |> Map.merge(row_views(Enum.reverse(row)), fn _k, a, b -> a * b end)
    end)

    field
    |> transpose()
    |> Enum.reduce(acc, fn row, acc ->
      acc
      |> Map.merge(row_views(row), fn _k, a, b -> a * b end)
      |> Map.merge(row_views(Enum.reverse(row)), fn _k, a, b -> a * b end)
    end)
    |> Map.values()
    |> Enum.max()
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
  end

  defp locate_trees(matrix) do
    matrix
    |> Enum.with_index()
    |> Enum.map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {height, x} -> %Tree{height: height, x: x, y: y} end)
    end)
  end

  defp visible_trees_in_row(row) do
    last_index = Enum.count(row)

    row
    |> Enum.reduce({MapSet.new(), -1}, fn
      %Tree{x: x, y: y} = tree, {acc, max_height} when 0 in [x, y] or last_index in [x, y] ->
        {MapSet.put(acc, tree), update_height(tree, max_height)}

      %Tree{height: height} = tree, {acc, max_height} when height > max_height ->
        {MapSet.put(acc, tree), height}

      _, acc ->
        acc
    end)
    |> elem(0)
  end

  defp row_views(row) do
    row
    |> Enum.reduce({%{}, []}, fn
      %Tree{height: height} = tree, {views, []} ->
        {Map.update(views, tree, 0, &(&1 * 0)), [height]}

      %Tree{height: height} = tree, {views, previous_trees} ->
        view_line = view_line(tree, previous_trees)
        view = Enum.count(view_line)
        # IO.inspect({tree, view_line, previous_trees, view})
        {Map.update(views, tree, view, &(&1 * view)), [height | previous_trees]}
    end)
    |> elem(0)
  end

  defp view_line(%Tree{height: height}, previous_trees) do
    Enum.reduce(previous_trees, {[], false}, fn
      _, {acc, true = stop} -> {acc, stop}
      previous_tree, {acc, _stop} ->
        {[previous_tree | acc], previous_tree >= height}
    end)
    |> elem(0)
  end

  defp update_height(%Tree{height: height}, max_height) when height > max_height, do: height
  defp update_height(_, max_height), do: max_height

  defp transpose(matrix), do: Enum.zip_with(matrix, & &1)
end
