defmodule Mindchat.BotTest do
  use ExUnit.Case
  @url "https://graph.facebook.com/v15.0/me/messages?access_token=EAARq4Cea5tEBAGVbOlTm38ZA4z58ZAOZCpiXFrfkGhM2PKxxnPsJtnHKHIQAZAIuhYVq0NwB9mR1n496cv6F4xNqNsitJgDrJ8SYTYPKbqg8IHP3sDUkhvO9Bqad6LRy7RTsVmfEsRcZAZBzZBKRa4rZAHAAyvfwUJaHsmtZCaFryqqTZBgNjNZCMLxZBBArNWUp7rYZD"
  @profile_url "https://graph.facebook.com/v15.0/me/messenger_profile?access_token=EAARq4Cea5tEBAGVbOlTm38ZA4z58ZAOZCpiXFrfkGhM2PKxxnPsJtnHKHIQAZAIuhYVq0NwB9mR1n496cv6F4xNqNsitJgDrJ8SYTYPKbqg8IHP3sDUkhvO9Bqad6LRy7RTsVmfEsRcZAZBzZBKRa4rZAHAAyvfwUJaHsmtZCaFryqqTZBgNjNZCMLxZBBArNWUp7rYZD"
    test "bot_endpoint" do
      assert Mindchat.Bot.bot_endpoint() == @url
    end

    test "bot_profile_endpoint" do
      assert Mindchat.Bot.bot_profile_endpoint() == @profile_url
    end

end
