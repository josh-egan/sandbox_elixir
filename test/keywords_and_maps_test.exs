# https://elixir.hexdocs.pm/keywords-and-maps.html

defmodule KeywordListsTest do
  use ExUnit.Case

  # A keyword list is a list of {atom, value} tuples: [a: 1, b: 2] == [{:a, 1}, {:b, 2}];
  # mostly used for optional args, e.g. String.split("1 2 3 4", " ", parts: 3, trim: true);
  # keys can repeat and order is kept, so [a: 0] ++ [a: 1, b: 2] gives [a: 0, a: 1, b: 2] and list[:a] returns the first (0);
  # pattern matching needs the same keys in the same order, otherwise MatchError

  test "can use a keyword list as shorthand for a list consisting of 2-item tuples" do
    assert [{:parts, 3}, {:trim, true}] == [parts: 3, trim: true]
    assert [{:foo, 4}, {:bar, "asdf"}] == [foo: 4, bar: "asdf"]
  end

  test "can use a keyword list to provide optional params to functions" do
    # The below is the full syntax, but it gets removed by formatters because the non-bracket syntax is preferred.
    # The non-bracket syntax only works when the keyword list is the final optional arg, which is standard.
    # assert String.split("1  2  3", " ", [trim: true]) == ["1", "2", "3"]

    assert String.split("1 2 3 4 5 6", " ") == ["1", "2", "3", "4", "5", "6"]
    assert String.split("1 2 3 4 5 6", " ", parts: 3) == ["1", "2", "3 4 5 6"]

    assert String.split("1  2  3", " ", trim: true) == ["1", "2", "3"]
    assert String.split("1  2  3", " ", parts: 3) == ["1", "", "2  3"]
    assert String.split("1  2  3", " ", parts: 3, trim: true) == ["1", "2", " 3"]
  end

  test "can do list operations on a keyword list" do
    assert [a: 1, b: 2, c: 3] ++ [aa: 4, bb: 5, cc: 6] == [a: 1, b: 2, c: 3, aa: 4, bb: 5, cc: 6]
  end

  test "can add multiple items with the same atom as the key" do
    assert [a: 1, b: 2] ++ [a: 3, b: 4] == [a: 1, b: 2, a: 3, b: 4]
  end

  test "can read the forst matching key with the access syntax" do
    test_list = [a: 1, b: 2, c: 3, a: 4]
    assert test_list[:a] == 1
    assert test_list[:c] == 3
  end
end

defmodule DoBlocksAndKeywordsTest do
  use ExUnit.Case

  # do/else blocks are sugar for keyword lists:
  # if true do "yes" else "no" end is the same as if(true, do: "yes", else: "no")

  test "can represent a do block as a keyword list" do
    test_fn = fn input ->
      if(input, do: "it was true", else: "it was false")
    end

    assert test_fn.(true) == "it was true"
    assert test_fn.(false) == "it was false"
  end
end

defmodule MapsAsKeyValuePairsTest do
  use ExUnit.Case

  # Maps use %{} and take any value as a key, with no ordering: %{:a => 1, 2 => :b};
  # map[:a] is 1 and a missing key map[:c] is nil;
  # a map pattern matches any map that has those keys (%{} = %{:a => 1} matches), but %{:c => c} = %{:a => 1} raises MatchError;
  # the Map module has Map.get/2, Map.put/3, and Map.to_list/1

  test "can use any value as a key and can access map values" do
    test_map = %{:a => "foo", 17 => false, :b => true, "some_key" => 7}
    assert test_map[:a] == "foo"
    assert test_map[17] == false
    assert test_map[:b] == true
    assert test_map["some_key"] == 7
    assert test_map["invalid"] == nil
  end

  test "can do pattern matching on a map" do
    test_map = %{:a => 1, :b => 2}
    %{:a => a} = test_map
    assert a == 1
  end
end

defmodule MapsOfPredefinedKeysTest do
  use ExUnit.Case

  # When all keys are atoms, use %{name: "John", age: 23};
  # map.name is "John" but map.agee raises KeyError;
  # %{map | name: "Mary"} updates an existing key, but %{map | agee: 27} raises KeyError (it can't add keys);
  # prefer map.key and pattern matching over the Map module for assertive code

  test "can use maps with all atoms when key names are known in advance" do
    assert %{:name => "asdf", :age => 17} == %{name: "asdf", age: 17}
  end

  test "can use dot syntax when all keys are atoms" do
    test_map = %{name: "asdf", age: 17}
    assert test_map.age == 17
  end

  test "can use the bar syntax to update an atom key" do
    test_map = %{name: "asdf", age: 17}
    assert test_map.name == "asdf"

    new_map = %{test_map | name: "foo"}
    assert new_map.name == "foo"
    assert new_map.age == 17
  end
end

defmodule NestedDataStructuresTest do
  use ExUnit.Case

  # Read nested data with access syntax: users[:john].age (users is a keyword list of maps);
  # put_in(users[:john].age, 31) sets a nested value;
  # update_in(users[:mary].languages, fn langs -> List.delete(langs, "Clojure") end) applies a function to a nested value

  test "can created nested data structures" do
    test_users = [
      john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
      mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
    ]

    assert test_users[:john].age == 27
  end

  test "the put_in function can be used to update an object in a list" do
    test_users = [
      john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
      mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
    ]

    updated_users = put_in(test_users[:john].age, 31)
    assert updated_users[:john].age == 31
  end

  test "the update_in function can update a list" do
    test_users = [
      john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
      mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
    ]

    updated_users =
      update_in(test_users[:mary].languages, fn languages -> List.delete(languages, "Clojure") end)

    assert updated_users[:mary].languages == ["Elixir", "F#"]
  end
end

# Summary: keyword lists for optional function args, maps for general key-value data
# and for data with a fixed set of keys
