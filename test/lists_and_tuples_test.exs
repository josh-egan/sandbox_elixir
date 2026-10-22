# https://elixir.hexdocs.pm/lists-and-tuples.html

defmodule ListTypesTest do
  use ExUnit.Case

  test "can define a list using square brackets" do
    assert [1, 2, 3]
  end

  test "can include multiple types in a single list" do
    assert [1, 2, 3, true, false, "foobar", nil]
  end

  test "can get the number of items in a list" do
    assert length([1, 2, 3]) == 3
  end

  test "can concatenate a list" do
    assert [1, 2, 3] ++ [4, 5, 6] == [1, 2, 3, 4, 5, 6]
  end

  test "can subtract from a list" do
    assert [1, 2, 3, 4] -- [2, 4] == [1, 3]
  end

  test "when substracting from a list, only the first occurance of each value is removed" do
    assert [1, 1, 2, 2, 3, 3, 3] -- [1, 2, 2, 3] == [1, 3, 3]
  end

  test "when substracting from a list, nothing is removed if the value is not found" do
    assert [1, 2, 3] -- [4, 5, 6] == [1, 2, 3]
    assert [1, 2, 3] -- [3, 4, 5, 6] == [1, 2]
  end

  test "subtracting from a list is value based, not order based" do
    assert [1, 2, 3, 4, 5, 6] -- [5, 2, 4, 1, 6] == [3]
  end

  test "lists, like all other data structures in elixir, are immutable" do
    test_list = [1, 2, 3, 4]
    assert test_list -- [1, 2] == [3, 4]
    assert test_list == [1, 2, 3, 4]
  end

  test "can get the first entry, the 'head' item, using the hd command" do
    assert hd([1, 2, 3]) == 1
  end

  test "can get everything except the first entry, the 'tail', using the tl command" do
    assert tl([1, 2, 3]) == [2, 3]
  end

  test "calling hd or tl on empty list throws" do
    # The code below fails at complile time.
    # hd([])
    # tl([])
  end
end

defmodule TupleTypesTest do
  use ExUnit.Case

  test "can define a tuple" do
    assert {:ok, "foo", 7} == {:ok, "foo", 7}
  end

  test "can get the number of items in a tuple" do
    assert tuple_size({:ok, "foo", 7}) == 3
  end

  test "can replace an element of a tuple" do
    test_tuple = {1, "hello"}
    assert put_elem(test_tuple, 1, "world") == {1, "world"}
  end

  test "tuples are immutable" do
    test_tuple = {1, "hello"}
    new_tuple = put_elem(test_tuple, 1, true)

    assert new_tuple == {1, true}
    assert test_tuple == {1, "hello"}
  end

  test "can access an item in a tuple" do
    assert elem({1, 2, 3, 4, 5, 6}, 4) == 5
  end

  # Contiguous in memory: {:ok, "hello"}, elem/2, put_elem/3, tuple_size/1
end

# =====
#
# What is the difference between lists and tuples?
#
# Lists are stored in memory as linked lists, meaning that each element in a list holds its value and points to
# the following element until the end of the list is reached. This means accessing the length of a list is a
# linear operation: we need to traverse the whole list in order to figure out its size.
#
# Tuples, on the other hand, are stored contiguously in memory. This means getting the tuple size or accessing
# an element by index is fast. On the other hand, updating or adding elements to tuples is expensive because it
# requires creating a new tuple in memory:
#
# When counting the elements in a data structure, Elixir also abides by a simple rule: the function is named
# size if the operation is in constant time (the value is pre-calculated) or length if the operation is linear
# (calculating the length gets slower as the input grows). As a mnemonic, both "length" and "linear" start with "l".

# Performance trade-offs: prepending vs appending to lists, updating tuples copies them,
# and the {:ok, value} / {:error, reason} return convention (e.g. File.read/1)
