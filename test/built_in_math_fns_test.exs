defmodule MathFunctionsTest do
  use ExUnit.Case

  test "can do basic math" do
    assert 3 + 4 == 7
    assert 3 * 4 == 12
    assert 12 / 4 == 3
    assert 12 - 5 == 7
  end

  test "can get the remainder" do
    assert rem(10, 3) == 1
    assert rem(25, 7) == 4
  end

  test "can use div to get an integer" do
    assert div(10, 2) === 5
  end

  test "the div function uses floor rounding" do
    assert div(20, 7) == 2
  end

  test "the round function does rounding" do
    assert round(3.0) == 3
    assert round(3.49) == 3
    assert round(3.50) == 4
    assert round(3.99) == 4
  end

  test "the trunc function does floor rounding" do
    assert trunc(3) == 3
    assert trunc(3.99999) == 3
  end
end
