defmodule SendingProcess do
  def run(process_id) do
    send(process_id, :ping)
  end
end

defmodule ExUnitTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import ExUnit.CaptureLog
  require Logger

  test "can use assert" do
    assert true == true
  end

  test "can use refute" do
    refute true == false
  end

  test "can use assert_received" do
    SendingProcess.run(self())
    assert_received :ping
  end

  test "can use capture_io" do
    assert capture_io(fn -> IO.puts("Hello World") end) == "Hello World\n"
  end

  test "can use capture_log" do
    assert String.contains?(capture_log(fn -> Logger.info("Hello World") end), "Hello World")
  end
end

# defmodule ExUnitLifecycleTest do
#   use ExUnit.Case

#   test ""
# end
