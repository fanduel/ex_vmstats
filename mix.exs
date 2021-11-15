defmodule ExVmstats.Mixfile do
  use Mix.Project

  @source_url "https://github.com/fanduel/ex_vmstats"
  @version "0.0.1"

  def project do
    [
      app: :ex_vmstats,
      version: @version,
      elixir: "~> 1.1",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package(),
      xref: [exclude: [ExStatsD]]
    ]
  end

  def application do
    [
      applications: [:logger],
      mod: {ExVmstats.Application, []}
    ]
  end

  defp deps do
    [
      {:ex_statsd, "~> 0.5", optional: true},
      {:ex_doc, ">= 0.25.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      description: "An Elixir package for pushing Erlang VM stats into StatsD.",
      maintainers: ["Greg Narajka"],
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @source_url}
    ]
  end

  defp docs do
    [
      extras: [
        LICENSE: [title: "License"],
        "README.md": [title: "Overview"]
      ],
      main: "readme",
      source_url: @source_url,
      formatters: ["html"]
    ]
  end
end
