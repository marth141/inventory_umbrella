defmodule QrGenTest do
  use ExUnit.Case
  doctest QrGen

  test "greets the world" do
    assert QrGen.hello() == :world
  end
end
