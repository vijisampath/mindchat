defmodule Mindchat.WelcomeTemplateTest do
  use ExUnit.Case

  @welcome %{"greeting" => %{"payload" => "welcome"}}
  test "welcomes the user" do
    assert Mindchat.WelcomeTemplate.welcome() == @welcome
  end

  @greeting %{
    "greeting" => [
      %{"locale" => "default", "text" => "Welcome"},
      %{"locale" => "en_US", "text" => "Search coin details with bot"}
    ]
  }
  test "greets the user" do
    assert Mindchat.WelcomeTemplate.greeting() == @greeting
  end

end
