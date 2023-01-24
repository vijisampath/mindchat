defmodule Mindchat.MessageTest do
  use ExUnit.Case
  @result "Hello buddy :)\nWelcome to Mindchat\n"
    test "greet" do
    assert Mindchat.Message.greet() == @result

    end

end
