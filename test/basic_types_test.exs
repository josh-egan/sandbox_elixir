defmodule IntegerTypesTest do
  use ExUnit.Case

  test "can define integers" do
    assert 4 == 4
  end

  test "can use is_integer to detect integers" do
    assert is_integer(4) == true
    assert is_integer(4.0) == false
  end

  test "can use binary to define an integer" do
    assert 0b000 == 0
    assert 0b001 == 1
    assert 0b010 == 2
    assert 0b011 == 3
    assert 0b100 == 4
    assert 0b101 == 5
    assert 0b110 == 6
    assert 0b111 == 7
    assert 0b1000 == 8
    assert 0b1001 == 9
    assert 0b1010 == 10
    assert 0b1011 == 11
    assert 0b1100 == 12
    assert 0b1101 == 13
    assert 0b1110 == 14
    assert 0b1111 == 15
  end

  # Octal numbers represent 3 bits in one character. Characters 0-7 represent the 8 possible states of 3 bits.
  test "can use octal to define an integer" do
    assert 0o644 == 420
    assert 0o0 == 0
    assert 0o1 == 1
    assert 0o7 == 7
    assert 0o10 == 8
    assert 0o17 == 15
    assert 0o20 == 16
    assert 0o30 == 24
    assert 0o40 == 32
    assert 0o100 == 64
    assert 0o110 == 72
    assert 0o111 == 73
    assert 0o200 == 128
    assert 0o1000 == 512
  end

  # Hexadecimal numbers represent 4 bits in one character. Characters 0-9 and A-F represent the 16 possible states of 4 bits.
  test "can use hex to define an integer" do
    assert 0x0 == 0
    assert 0x1 == 1
    assert 0x9 == 9
    assert 0xA == 10
    assert 0xB == 11
    assert 0xC == 12
    assert 0xD == 13
    assert 0xE == 14
    assert 0xF == 15
    assert 0xF == 15
    assert 0x10 == 16
    assert 0x1A == 26
    assert 0x20 == 32
    assert 0xF0 == 240
    assert 0xFF == 255
    assert 0x100 == 256
    assert 0xFFF == 4095
  end
end

defmodule FloatTypesTest do
  use ExUnit.Case

  test "can define floats" do
    assert 3.14 == 3.14
  end

  test "a zero is required in front of the decimal" do
    assert 0.14 == 0.14
  end

  test "can use e syntax" do
    assert 3.7257e3 == 3725.7
    assert 3.7257e-3 == 0.0037257
  end

  test "can do math" do
    assert 3 + 4 == 7
    assert 3 * 4 == 12
    assert 12 / 4 == 3
    assert 12 - 5 == 7
  end

  test "can use is_float to check if a value is a float" do
    assert is_float(3.0) == true
    assert is_float(3) == false
    assert is_float("foo") == false
  end
end

defmodule NumberTypesTest do
  use ExUnit.Case

  test "can use is_number to check if a value is a number" do
    assert is_number(3) == true
    assert is_number(3.0) == true
    assert is_number(true) == false
    assert is_number("foo") == false
  end
end

defmodule BooleanTypesTest do
  use ExUnit.Case

  test "can use true and false" do
    assert true == true
    assert false == false
  end

  test "can use is_boolean to check if a value is a boolean" do
    assert is_boolean(true) == true
    assert is_boolean(false) == true
    assert is_boolean("true") == false
    assert is_boolean(1) == false
    # `true == false` would trigger a type warning: the compiler knows the
    # two literals are disjoint types, so the comparison is always false.
  end

  test "true and false atoms are also booleans" do
    assert true == true
    assert false == false
  end

  test "can use and, or, and not operators" do
    assert 3 == 3 and 4 == 16 / 4
    assert 2 == 7 or 20 / 5 == 4
    # The "not" operator is the bang operator that reverses a boolean value.
    assert not false
  end

  test "all types except nil are truthy" do
    assert !!0 == true
    assert !!0.0 == true
    assert !!"" == true
    assert !![] == true
    assert !!{} == true
    assert !!nil == false
  end

  test "can use operators to coerce values into their truthy state" do
    assert 3 == 3 && 4
    assert 0 && 1
    assert false || "false"
    assert false || 0
    assert !0 == false
    assert !nil == true
  end
end

# An atom is Elixir's concept of a symbol.
# Atoms are global. You don't really "define" an atom: writing :ok anywhere uses the same atom.
# Every place in the running system that writes :ok gets the same atom.
# he Erlang VM keeps one atom table for each running VM. The first time :ok appears, the VM adds it to the table.
# After that, every :ok refers to that one entry.
defmodule AtomTypesTest do
  use ExUnit.Case

  test "can define a custom atom" do
    assert :foobar_atom_test == :foobar_atom_test

    # The test below fails at compile time because it is not allowed to do illegal operations with atoms.
    # assert :foobar_atom_test != :atom_test_the_second
  end
end

defmodule StringTypesTest do
  use ExUnit.Case

  test "Can define a string" do
    assert "foobar" == "foobar"
  end

  test "can concatenate strings" do
    assert "foo" <> "bar" == "foobar"
  end

  test "can do string interpolation" do
    number = 42
    assert "the answer is #{number}" == "the answer is 42"
  end
end

defmodule ComparisonOperatorsTest do
  use ExUnit.Case

  test "can test equality" do
    assert 3 == 3
  end

  test "can test inequality" do
    assert 2 != 3
  end

  test "can test greater than and less than" do
    assert 2 < 3
    assert 2 <= 3
    assert 3 <= 3
    assert 3 >= 3
    assert 4 > 3
  end

  test "the strict comparison operator can distinguish between values" do
    # The below test fails at compile time.
    # assert 1 !== 1.0
  end
end
