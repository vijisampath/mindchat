defmodule Mindchat.QuickRepliesTemplateTest do
  use ExUnit.Case

  @prepare_replies   %{
    "content_type"=> "text",
    "title" => "01coin",
    "payload" => "coinid_01coin"
    }

  @template %{"message" => "coinid_01coin", "messaging_type" => "RESPONSE", "recipient" => "01coin"}

    test "prepare_replies" do
      assert Mindchat.QuickRepliesTemplate.prepare_replies({"01coin","coinid_01coin"}) == @prepare_replies
    end

    test "template" do
      assert Mindchat.QuickRepliesTemplate.template("01coin","coinid_01coin") == @template
    end

end
