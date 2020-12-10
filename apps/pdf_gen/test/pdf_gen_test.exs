defmodule PdfGenTest do
  use ExUnit.Case
  doctest PdfGen

  test "greets the world" do
    assert PdfGen.hello() == :world
  end
end
