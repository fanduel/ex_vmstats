[![Build Status](https://travis-ci.org/fanduel/ex_vmstats.svg?branch=master)](https://travis-ci.org/fanduel/ex_vmstats)

# ExVmstats

An Elixir package for pushing Erlang VM stats into StatsD, based on [ferd/vmstats](https://github.com/ferd/vmstats).

## Installation

  1. Add ex_vmstats to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ex_vmstats, "~> 0.0.1"}]
    end
    ```

  2. Ensure ex_vmstats is started before your application:

    ```elixir
    def application do
      [applications: [:ex_vmstats]]
    end
    ```

## Dependencies

Your project must include [ExStatsD](https://github.com/CargoSense/ex_statsd), unless you use a custom backend. (See configuration options below.)

## Configuration

Configure ExVmstats using `Mix.Config`, normally somewhere in `config/`:

```elixir
use Mix.Config

config :ex_vmstats,
  namespace: "vm_stats",
  backend: :ex_statsd,
  interval: 3000,
  use_histogram: false,
  sched_time: false,
  append_hostname: false

```

Defaults are shown. The configuration options are:

* **namespace**: This will be prepended to all metrics sent by ExVmStats, but will follow the ExStatsD namespace (if applicable).

* **backend**: Out of the box, the only supported backend is ExStatsD. A custom backend module may be identified here. Backend modules must define the functions `&timer/2`, `&counter/2`, and one or both of `&gauge/2` and `&histogram/2`. The arguments passed to each are `(value, metric)`.

* **interval**: The number of milliseconds to wait between VM stats deliveries.

* **use_histogram**: Use histograms instead of gauges. For use with Datadog's DogStatD.

* **sched_time**: Enable reporting of Erlang `scheduler_wall_time` statistics (if available). For more information, see the section dealing with `scheduler_wall_time` [here](http://www1.erlang.org/doc/man/erlang.html#statistics-1).
