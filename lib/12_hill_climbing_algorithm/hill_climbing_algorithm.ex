defmodule AOC2022.HillClimbingAlgorithm do
  @moduledoc """
  --- Day 12: Hill Climbing Algorithm ---
  You try contacting the Elves using your handheld device, but the river you're
  following must be too low to get a decent signal.

  You ask the device for a heightmap of the surrounding area (your puzzle input).
  The heightmap shows the local area from above broken into a grid; the elevation
  of each square of the grid is given by a single lowercase letter, where a is the
  lowest elevation, b is the next-lowest, and so on up to the highest elevation, z.

  Also included on the heightmap are marks for your current position (S) and the
  location that should get the best signal (E). Your current position (S) has elevation a,
  and the location that should get the best signal (E) has elevation z.

  You'd like to reach E, but to save energy, you should do it in as few steps as possible.
  During each step, you can move exactly one square up, down, left, or right.
  To avoid needing to get out your climbing gear, the elevation of the destination square
  can be at most one higher than the elevation of your current square; that is, if your current
  elevation is m, you could step to elevation n, but not to elevation o.
  (This also means that the elevation of the destination square can be much lower than the elevation of your current square.)

  For example:

  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
  Here, you start in the top-left corner; your goal is near the middle.
  You could start by moving down or right, but eventually you'll need to head toward the e at the bottom.
  From there, you can spiral around to the goal:

  v..v<<<<
  >v.vv<<^
  .>vv>E^^
  ..v>>>^^
  ..>>>>>^
  In the above diagram, the symbols indicate whether the path exits each square
  moving up (^), down (v), left (<), or right (>). The location that should get
  the best signal is still E, and . marks unvisited squares.

  This path reaches the goal in 31 steps, the fewest possible.

  What is the fewest steps required to move from your current position to the location that should get the best signal?

  --- Part Two ---
  As you walk up the hill, you suspect that the Elves will want to turn this into a hiking trail.
  The beginning isn't very scenic, though; perhaps you can find a better starting point.

  To maximize exercise while hiking, the trail should start as low as possible: elevation a.
  The goal is still the square marked E. However, the trail should still be direct, taking the fewest steps to reach its goal.
  So, you'll need to find the shortest path from any square at elevation a to the square marked E.

  Again consider the example from above:

  Sabqponm
  abcryxxl
  accszExk
  acctuvwj
  abdefghi
  Now, there are six choices for starting position (five marked a, plus the square marked S that counts as being at elevation a).
  If you start at the bottom-left square, you can reach the goal most quickly:

  ...v<<<<
  ...vv<<^
  ...v>E^^
  .>v>>>^^
  >^>>>>>^
  This path reaches the goal in only 29 steps, the fewest possible.

  What is the fewest steps required to move starting from any square with elevation a to the location that should get the best signal?
  """

  defmodule Heightmap do
    defstruct [:grid, :target]

    def height_at(%Heightmap{grid: grid}, coord), do: grid[coord]

    def height_ats_with_height(%Heightmap{grid: grid}, predicate) do
      grid
      |> Map.filter(fn {_, height} -> predicate.(height) end)
      |> Map.keys()
    end

    def valid_coord?(%Heightmap{grid: grid}, coord), do: Map.has_key?(grid, coord)
  end

  def solve(input, starting_points) do
    {start, heightmap} = parse(input)

    starting_points.(start, heightmap)
    |> Enum.map(fn coord -> steps_to_target([{coord, 0}], heightmap, MapSet.new([coord])) end)
    |> Enum.reject(&(&1 == :not_found))
    |> Enum.min()
  end

  def original_start(start, _heightmap), do: [start]

  def every_a(_start, heightmap) do
    Heightmap.height_ats_with_height(heightmap, &(&1 == ?a))
  end

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index(1)
    |> Enum.reduce({%{}, 0, 0}, fn {line, row}, accout ->
      to_charlist(line)
      |> Enum.with_index(1)
      |> Enum.reduce(accout, fn {char, col}, {grid, start, stop} ->
        coord = {row, col}

        case char do
          ?S -> {Map.put(grid, coord, ?a), coord, stop}
          ?E -> {Map.put(grid, coord, ?z), start, coord}
          _ -> {Map.put(grid, coord, char), start, stop}
        end
      end)
    end)
    |> then(fn {grid, start, target} -> {start, %Heightmap{grid: grid, target: target}} end)
  end

  defp steps_to_target([], _heightmap, _visited), do: :not_found

  defp steps_to_target([{target, steps} | _tail], %Heightmap{target: target}, _visited), do: steps

  defp steps_to_target([{coord, steps} | tail], heightmap, visited) do
    next =
      valid_moves(coord, heightmap)
      |> Enum.reject(&MapSet.member?(visited, &1))
      |> Enum.map(&{&1, steps + 1})

    next_visited = next |> Enum.map(&elem(&1, 0)) |> MapSet.new()

    queue = tail ++ next
    steps_to_target(queue, heightmap, MapSet.union(visited, next_visited))
  end

  defp valid_moves({row, col} = current_coord, heightmap) do
    current_height = Heightmap.height_at(heightmap, current_coord)

    [{-1, 0}, {1, 0}, {0, -1}, {0, 1}]
    |> Enum.map(fn {x, y} -> {row + x, col + y} end)
    |> Enum.filter(fn coord -> valid_move(coord, heightmap, current_height) end)
  end

  defp valid_move(coord, heightmap, current_height) do
    Heightmap.valid_coord?(heightmap, coord) &&
      Heightmap.height_at(heightmap, coord) - current_height <= 1
  end
end
