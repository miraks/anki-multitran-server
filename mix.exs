defmodule AnkiMultitran.Mixfile do
  use Mix.Project

  def project do
    [
      app: :anki_multitran,
      version: "0.1.0",
      elixir: "~> 1.3",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def application do
    [
      mod: {AnkiMultitran, []},
      applications: [:logger, :cowboy, :plug, :ecto, :sqlite_ecto]
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:plug, "~> 1.2"},
      {:ecto, "~> 1.1"},
      {:sqlite_ecto, "~> 1.1"},
      {:poison, "~> 1.0"},
      {:credo, "~> 0.4", only: [:dev, :test]}
    ]
  end
end
