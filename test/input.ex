defmodule AOC2022.Input do
  def read(file_name) do
    {:ok, input} = File.read("test/inputs/#{file_name}")

    input
  end
end
