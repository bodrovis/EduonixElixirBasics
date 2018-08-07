defmodule GameOfStones.MixProject do
  use Mix.Project

  def project do
    [
      app: :game_of_stones,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:colors, "~> 1.1"}, # X.Y.Z
      # 1.1, 1.2, 1.3, 1.10... - allow
      # 2.1, 3.10, 100.9000 - don't allow
      # X - major version number
      # Y - minor version
      # Z - patch version
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end
end
