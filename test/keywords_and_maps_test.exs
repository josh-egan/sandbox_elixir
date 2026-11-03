# https://elixir.hexdocs.pm/keywords-and-maps.html

defmodule KeywordListsTest do
  use ExUnit.Case

  # A keyword list is a list of {atom, value} tuples: [a: 1, b: 2] == [{:a, 1}, {:b, 2}];
  # mostly used for optional args, e.g. String.split("1 2 3 4", " ", parts: 3, trim: true);
  # keys can repeat and order is kept, so [a: 0] ++ [a: 1, b: 2] gives [a: 0, a: 1, b: 2] and list[:a] returns the first (0);
  # pattern matching needs the same keys in the same order, otherwise MatchError
end

defmodule DoBlocksAndKeywordsTest do
  use ExUnit.Case

  # do/else blocks are sugar for keyword lists:
  # if true do "yes" else "no" end is the same as if(true, do: "yes", else: "no")
end

defmodule MapsAsKeyValuePairsTest do
  use ExUnit.Case

  # Maps use %{} and take any value as a key, with no ordering: %{:a => 1, 2 => :b};
  # map[:a] is 1 and a missing key map[:c] is nil;
  # a map pattern matches any map that has those keys (%{} = %{:a => 1} matches), but %{:c => c} = %{:a => 1} raises MatchError;
  # the Map module has Map.get/2, Map.put/3, and Map.to_list/1
end

defmodule MapsOfPredefinedKeysTest do
  use ExUnit.Case

  # When all keys are atoms, use %{name: "John", age: 23};
  # map.name is "John" but map.agee raises KeyError;
  # %{map | name: "Mary"} updates an existing key, but %{map | agee: 27} raises KeyError (it can't add keys);
  # prefer map.key and pattern matching over the Map module for assertive code
end

defmodule NestedDataStructuresTest do
  use ExUnit.Case

  # Read nested data with access syntax: users[:john].age (users is a keyword list of maps);
  # put_in(users[:john].age, 31) sets a nested value;
  # update_in(users[:mary].languages, fn langs -> List.delete(langs, "Clojure") end) applies a function to a nested value
end

# Summary: keyword lists for optional function args, maps for general key-value data
# and for data with a fixed set of keys
