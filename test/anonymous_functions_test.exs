# https://elixir.hexdocs.pm/anonymous-functions.html

defmodule IdentifyingFunctionsTest do
  use ExUnit.Case

  # Functions are identified by name and arity, e.g. trunc/1 or Kernel.trunc/1;
  # h trunc/1 in iex shows the docs
end

defmodule DefiningAnonymousFunctionsTest do
  use ExUnit.Case

  # add = fn a, b -> a + b end is called with a dot: add.(1, 2);
  # is_function(add) and is_function(add, 2) check that a value is a function and its arity
end

defmodule ClosuresTest do
  use ExUnit.Case

  # An anonymous function can use variables from where it was defined (double = fn a -> add.(a, a) end),
  # but variables assigned inside it don't leak out: x = 42; (fn -> x = 0 end).() leaves x at 42
end

defmodule ClausesAndGuardsTest do
  use ExUnit.Case

  # fn can have several clauses with patterns and guards, like case
  # (fn x, y when x > 0 -> x + y; x, y -> x * y end), and every clause must take the same number of arguments
end

defmodule CaptureOperatorTest do
  use ExUnit.Case

  # & turns a named function or operator into a value: &is_atom/1, &String.length/1, &+/2;
  # &1 is the first argument in shorthand functions: &is_function(&1, 2), &(&1 + 1), &"Good #{&1}"
end
