defmodule SocketClientTest do
  use ExUnit.Case
  doctest SocketClient

  test "greets the world" do
    assert SocketClient.hello() == :world
  end
end
