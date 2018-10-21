defmodule ConsoleClientTest do
  use ExUnit.Case
  doctest ConsoleClient

  test "greets the world" do
    assert ConsoleClient.hello() == :world
  end
end
