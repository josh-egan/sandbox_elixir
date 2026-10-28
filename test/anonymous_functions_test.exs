# https://elixir.hexdocs.pm/anonymous-functions.html

defmodule IdentifyingFunctionsTest do
  use ExUnit.Case

  # Functions are identified by name and arity, e.g. trunc/1 or Kernel.trunc/1;
  # h trunc/1 in iex shows the docs
end

defmodule AnonymousFunctionsTest do
  use ExUnit.Case

  # add = fn a, b -> a + b end is called with a dot: add.(1, 2);
  # is_function(add) and is_function(add, 2) check that a value is a function and its arity

  # An anonymous function can use variables from where it was defined (double = fn a -> add.(a, a) end),
  # but variables assigned inside it don't leak out: x = 42; (fn -> x = 0 end).() leaves x at 42

  test "can define and use an anonymous function. Calling an anonymous function requires a '.', e.g. my_func.(arg1, arg2)" do
    add = fn a, b -> a + b end
    assert add.(1, 3) == 4
  end

  test "can use is_function to check whether a thing is a function, and can also check its arity" do
    add = fn a, b -> a + b end
    assert is_function(add)
    assert is_function(add, 2)

    # The below line throws a compile time warning.
    # assert !is_function(add, 1)
  end

  test "a function closure ensures that its variables do not effect the outside environment" do
    a = 8
    add = fn a, b -> a + b end
    double = fn a -> add.(a, a) end
    assert double.(a) == 16
    assert double.(7) == 14
  end
end

defmodule ClausesAndGuardsTest do
  use ExUnit.Case

  # fn can have several clauses with patterns and guards, like case
  # (fn x, y when x > 0 -> x + y; x, y -> x * y end), and every clause must take the same number of arguments

  test "can use a guard clause as part of a function definition" do
    add_or_subtract = fn
      x, y when x > 0 -> x + y
      x, y -> x - y
    end

    assert add_or_subtract.(3, 9) == 12
    assert add_or_subtract.(-7, 1) == -8
  end

  test "can only use guard clauses when all functions have the same arity" do
    add_or_subtract = fn
      x, y when x > 0 -> x + y
      # The below line throws a compile time error.
      # x, y, z when x > -10 -> x * y
      x, y -> x - y
    end

    assert add_or_subtract.(3, 9) == 12
    assert add_or_subtract.(-7, 1) == -8
  end
end

defmodule CaptureOperatorTest do
  use ExUnit.Case

  # & turns a named function or operator into a value: &is_atom/1, &String.length/1, &+/2;
  # &1 is the first argument in shorthand functions: &is_function(&1, 2), &(&1 + 1), &"Good #{&1}"

  test "can use the capture operator to capture a function as a variable" do
    test_fn = &String.length/1
    assert test_fn.("asdf") == 4
  end

  test "can use the capture operator to capture operators because they are functions under the hood" do
    add = &+/2
    assert add.(3, 7) == 10
  end

  test "can use the capture operator to create wrapper functions and can capture arguments" do
    is_arity_2 = &is_function(&1, 2)
    assert is_arity_2.(&+/2)
    assert !is_arity_2.(&String.length/1)
  end
end
