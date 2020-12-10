# QrGen

**TODO: Add description**

## Building

Pre-Requisite: Elixir installed

1. After cloning the repository, run `mix deps.get`
2. Not proper, but use `iex -S mix` to run it
3. in `iex>` use `QrGen.create_labels_for("THING-", 0, 100)`
4. Labels!!!

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `qr_gen` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:qr_gen, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/qr_gen](https://hexdocs.pm/qr_gen).
