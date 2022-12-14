defmodule Aoc2022.MixProject do
  use Mix.Project

  def project do
    [
      app: :aoc2022,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      elixirc_paths: elixirc_paths(Mix.env())
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler, "~> 0.26.0"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/input.ex"]
  defp elixirc_paths(_), do: ["lib"]
end
