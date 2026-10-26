# https://elixir.hexdocs.pm/pattern-matching.html

defmodule MatchOperatorTest do
  use ExUnit.Case

  # = is the match operator, not assignment: x = 1 binds, 1 = x matches, 2 = x raises MatchError
  test "the match operator can be used to assign variables and to verify a value" do
    x = 1
    1 = x
    assert 1 = x
  end

  test "the match operator throws a MatchError if there is no match" do
    x = 1
    assert_raise MatchError, fn -> 2 = x end
  end
end

defmodule PatternMatchingTest do
  use ExUnit.Case

  # Destructuring tuples {a, b, c} = {:hello, "world", 42}, mismatched sizes/types raise MatchError,
  # matching on values like {:ok, result} = {:ok, 13}, lists [a, b, c] = [1, 2, 3],
  # and [head | tail] = [1, 2, 3] (plus prepending with [0 | list])
  test "the match operator can be used for pattern matching, or destructuring" do
    {a, b, c} = {:hello, 1, "foo"}
    assert a == :hello
    assert b == 1
    assert c == "foo"
  end

  test "the match operator throws a MatchError if the tuples have different sizes" do
    assert_raise MatchError, fn -> {_a, _b, _c} = Function.identity({"foo", 2}) end
  end

  test "the match operator throws a MatchError if the types are not the same" do
    assert_raise MatchError, fn -> {_a, _b, _c} = Function.identity([1, "foo", :hi]) end
  end

  test "can use the match operator to only work with specific results" do
    {:ok, result} = {:ok, "asdf"}
    assert result == "asdf"

    assert_raise MatchError, fn -> {:ok, _bad_result} = Function.identity({:error, "nope"}) end
  end

  test "can use pattern matching with lists" do
    [a, b, c] = [2, 4, 6]
    assert a == 2
    assert b == 4
    assert c == 6
  end

  test "a list can use pattern matching on its head and tail" do
    [head | tail] = [1, 2, 3, 4]
    assert head == 1
    assert tail == [2, 3, 4]
  end

  test "the [head | tail] format can also be used for prepending values" do
    arr = [2, 3, 4]
    assert [1 | arr] == [1, 2, 3, 4]
  end
end

defmodule PinOperatorTest do
  use ExUnit.Case

  # Variables can be rebound; ^x matches against the existing value instead of rebinding,
  # a variable can only bind once per pattern ({y, y} = {1, 2} fails), and _ ignores a value

  test "the match operator can be used to re-assign a variable" do
    x = 1
    assert x == 1

    x = 2
    assert x == 2
  end

  test "the pin operator can be used to ensure the value of a variable does not change" do
    x = "foo"
    assert x == "foo"

    assert_raise MatchError, fn -> ^x = Function.identity(1) end
  end
end
