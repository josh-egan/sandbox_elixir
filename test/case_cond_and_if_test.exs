# https://elixir.hexdocs.pm/case-cond-and-if.html

defmodule ExpressionsTest do
  use ExUnit.Case

  # Everything is an expression: rebinding x inside an if doesn't change the outer x,
  # so assign the result instead (x = if true do x + 1 else x end); if is a macro, prefer cond over nested ifs

  # An "expression" is a line of code that returns a value.
  # A "statement" is a line of code is a line of code that does not return a value.
  # In Elixir, *ALL* lines are expressions. A value is returned by every line of code.
  # As a result of this, there is no "return" keyword for functions.
  # The last expression in a function, if block, etc. becomes the return value for that block of code.

  defp test_fn(x) do
    a = x + 7
    b = a * 2
    c = b - x
    c + a
  end

  test "the last expression is returned from if blocks" do
    result =
      if true do
        x = 1
        y = 2
        z = x + y
        z * 5
      end

    assert result == 15
  end

  test "the last expression is returned from function blocks" do
    assert test_fn(8) == 37
  end
end

defmodule CaseTest do
  use ExUnit.Case

  # case runs the first clause whose pattern matches, e.g. {1, x, 3} binds x; _ matches anything,
  # ^x matches an existing value, when adds guards (a failing guard tries the next clause),
  # and no matching clause raises CaseClauseError

  defp testing_case(x) do
    case x do
      "foo" ->
        "foo provided"

      1 ->
        "1 provided"

      {1, a, 3} ->
        "tuple provided match { 1, a, 3 } where a is #{a}"

      _ ->
        "default clause reached with #{x}"
    end
  end

  defp guarded_case(x) do
    case x do
      a when a > 0 ->
        "#{a} > 0"

      a when a < 0 ->
        "#{a} < 0"

      _ ->
        "0"
    end
  end

  defp no_default_case(x) do
    case x do
      i when is_integer(i) ->
        "int"

      s when is_binary(s) ->
        "string"
    end
  end

  test "can use the case statement" do
    assert testing_case("foo") == "foo provided"
    assert testing_case(1) == "1 provided"
    assert testing_case({1, 7, 3}) == "tuple provided match { 1, a, 3 } where a is 7"
    assert testing_case(true) == "default clause reached with true"
  end

  test "can use guard statements in a case clause" do
    assert guarded_case(3) == "3 > 0"
    assert guarded_case(-7) == "-7 < 0"
    assert guarded_case(0) == "0"
  end

  test "a CaseClauseError is raised if no matching clause is found" do
    assert no_default_case(17) == "int"
    assert no_default_case("foo") == "string"
    assert_raise CaseClauseError, fn -> no_default_case(Function.identity(true)) end
  end
end

defmodule IfTest do
  use ExUnit.Case

  # if runs its body when the condition is truthy (anything but false or nil),
  # returns nil when falsy unless there is an else block

  test "if blocks work" do
    result =
      if 1 == 1 do
        "ran"
      else
        flunk("this should not be possible!")
      end

    assert result == "ran"
  end
end

defmodule CondTest do
  use ExUnit.Case

  # cond returns the first condition that isn't false or nil
  # a final true -> clause acts as else or default.
  # if no truthy condition exists, it raises CondClauseError

  defp testing_cond(x) do
    cond do
      is_binary(x) ->
        "hello there #{x}"

      is_integer(x) && x > 5 ->
        x + 7

      is_integer(x) ->
        x - 5

      true ->
        "default condition reached"
    end
  end

  defp no_default_cond(x) do
    cond do
      is_binary(x) ->
        "hello there #{x}"

      is_boolean(x) ->
        "it's #{x}"
    end
  end

  test "a cond block works like a combination of case and if" do
    assert testing_cond("bob") == "hello there bob"
    assert testing_cond(9) == 16
    assert testing_cond(false) == "default condition reached"
  end

  test "a cond block returns the first matching condition" do
    assert testing_cond(10) == 17
    assert testing_cond(3) == -2
  end

  test "a cond block without a default throws a CondClauseError if a match is not found" do
    assert no_default_cond("asdf") == "hello there asdf"
    assert no_default_cond(true) == "it's true"
    assert_raise CondClauseError, fn -> no_default_cond(18) end
  end
end
