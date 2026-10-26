# https://elixir.hexdocs.pm/case-cond-and-if.html

defmodule CaseTest do
  use ExUnit.Case

  # case runs the first clause whose pattern matches, e.g. {1, x, 3} binds x; _ matches anything,
  # ^x matches an existing value, when adds guards (a failing guard tries the next clause),
  # and no matching clause raises CaseClauseError
end

defmodule IfTest do
  use ExUnit.Case

  # if runs its body when the condition is truthy (anything but false or nil),
  # returns nil when falsy unless there is an else block
end

defmodule ExpressionsTest do
  use ExUnit.Case

  # Everything is an expression: rebinding x inside an if doesn't change the outer x,
  # so assign the result instead (x = if true do x + 1 else x end); if is a macro, prefer cond over nested ifs
end

defmodule CondTest do
  use ExUnit.Case

  # cond returns the first condition that isn't false or nil, a final true -> clause acts as else,
  # and no truthy condition raises CondClauseError
end
