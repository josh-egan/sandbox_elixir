defmodule SandboxElixirTest do
  use ExUnit.Case
  doctest SandboxElixir

  test "greets the world" do
    assert SandboxElixir.hello() == :world
  end
end
