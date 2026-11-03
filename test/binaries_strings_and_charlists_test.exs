# https://elixir.hexdocs.pm/binaries-strings-and-charlists.html

defmodule UnicodeAndCodePointsTest do
  use ExUnit.Case

  # Each character has a code point: ?a is 97, ?ł is 322; "a" == "a",
  # and code points are often written in hex (0x0061 == 97)

  test "can reveal a characters numerical code point using the ? operator" do
    # ASCII character codes: https://www.ascii-code.com/
    assert ?a === 97
    assert ?0 === 48
    assert ?9 === 57
    assert ?+ === 43
    assert ?Y === 89

    # UTF-8 character codes: https://www.charset.org/utf-8
    assert ?Å === 197
    assert ?ê === 234
    assert ?ϥ === 997
    assert ?你 === 194_564
  end
end

defmodule Utf8AndEncodingsTest do
  use ExUnit.Case

  # UTF-8 stores each code point in 1-4 bytes, so String.length("héllo") is 5 but byte_size is 6;
  # a grapheme can span several code points: String.codepoints("👩‍🚒") has 3, String.graphemes has 1;
  # "hełło" <> <<0>> or IO.inspect(s, binaries: :as_binaries) shows the raw bytes

  test "can get length of string characters using String.length even when underlying characters use many bytes" do
    assert String.length("asdf") == 4
    assert String.length("Åêϥ你") == 4
    assert String.length("👩‍🚒") == 1
  end

  test "can get bytes used in a string" do
    assert byte_size("asdf") == 4
    assert byte_size("Åêϥ你") == 10
    assert byte_size("👩‍🚒") == 11
  end

  test "can get code points from a string" do
    assert String.codepoints("asdf") == ["a", "s", "d", "f"]
    assert String.codepoints("Åêϥ你") == ["Å", "ê", "ϥ", "你"]
    assert String.codepoints("👩‍🚒") == ["👩", "\u200D", "🚒"]
  end
end

defmodule BitstringsTest do
  use ExUnit.Case

  # A bitstring is a contiguous sequence of bits in memory.
  # <<>> builds a bitstring; each value is 8 bits unless sized with ::n or ::size(n):
  # <<42>> == <<42::8>>, <<0::1, 0::1, 1::1, 1::1>> == <<3::4>>, and overflow truncates (<<1>> == <<257>>)
end

defmodule BinariesTest do
  use ExUnit.Case

  # A binary is a bitstring whose bit count is divisible by 8: is_binary(<<3::4>>) is false, is_binary(<<42::16>>) is true;
  # match with <<0, 1, x>>, take the rest with x::binary, or a fixed chunk with binary-size(2)
end

defmodule StringsAreBinariesTest do
  use ExUnit.Case

  # Strings are UTF-8 binaries, but not every binary is valid UTF-8 (String.valid?(<<239, 191, 19>>) is false);
  # <> concatenates binaries; <<head, rest::binary>> = "über" splits the ü bytes, so use x::utf8 to match a code point
end

defmodule CharlistsTest do
  use ExUnit.Case

  # A charlist is a list of code points, mostly for Erlang interop: ~c"hello" == [?h, ?e, ?l, ?l, ?o];
  # IEx prints all-ASCII lists as charlists ([99, 97, 116] shows ~c"cat"), inspect(l, charlists: :as_list) avoids that;
  # to_charlist/to_string convert, and ++ joins lists while <> joins binaries (mixing them raises ArgumentError)

  test "can define a character list using single quotes" do
    # The below syntax is now deprecated and throws a compile time warning
    # assert 'hello' == [104, 101, 108, 108, 111]
    assert ~c'hello' == [104, 101, 108, 108, 111]
  end
end
