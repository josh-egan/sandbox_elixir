defmodule IntegerTypesTest do
  use ExUnit.Case

  test "can define integers" do
    assert 4 == 4
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
end

defmodule BooleanTypesTest do
  use ExUnit.Case

  test "can use true and false" do
    assert true == true
    refute true == false
    refute false == true
    assert false == false
  end

  test "all types except nil are truthy" do
    assert !!0 == true
    assert !!0.0 == true
    assert !!"" == true
    assert !![] == true
    assert !!{} == true
    assert !!nil == false
  end
end
