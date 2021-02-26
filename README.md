# sandbox_elixir

Repo for exploring [elixir](https://elixir-lang.org/).

## Setup

Follow this tutorial to install `elixir` using `asdf`: https://thinkingelixir.com/install-elixir-using-asdf/

## Documentation

- https://elixir-lang.org/getting-started/introduction.html
- https://elixirschool.com/en/

## REPL

Use `iex` in the terminal launch interactive elixir.

## Files

Create files using the `.exs` extenion. Files can be exucuted using `elixir`. For example: `elixir sample.exs`

## Use Mix to generate elixir projects

`mix new my_project_name`

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `my_project_name` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:my_project_name, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/my_project_name](https://hexdocs.pm/my_project_name).

## Install dependencies

Add dependencies to the `mix.exs` file, then run `mix deps.get` on the command line.

## Run tests in watch mode

### Install mix_test_watch

Install mix_test_watch: https://github.com/lpil/mix-test.watch by adding this line to your deps in mix.exs:

```elixir
{:mix_test_watch, "~> 1.0", only: :dev, runtime: false}
```

Add `:iex` to the `extra_applications` in mix.exs

```elixir
def application do
  [
    extra_applications: [:logger, :iex]
  ]
end
```

#### On Linux

Install `inotify-tools`

```bash
sudo apt update
sudo apt install inotify-tools
```

### Run the tests

Once installation is complete, run the tests in watch mode using `mix test.watch`.
