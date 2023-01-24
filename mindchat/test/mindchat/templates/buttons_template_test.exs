defmodule Mindchat.ButtonTemplateTest do
  use ExUnit.Case

  @prepare_button %{"payload" => "search_id", "title" => "id", "type" => "postback"}

  @attachment  %{
      "type" => "postback",
      "payload" => "search_id"
      }

@message %{
  "attachment" => %{
    "payload" => %{
      "buttons" => [
        %{"payload" => "search_id", "title" => "id", "type" => "postback"},
        %{"payload" => "search_name", "title" => "name", "type" => "postback"}
      ],
      "template_type" => "button",
      "text" => "Welcome Vijaylakshmi to Gecko coin Chat Bot!\n Do you want Search by Coin Id or Coin Name?"
    },
    "type" => "template"
  }
}
@template %{
  "message" => %{
    "attachment" => %{
      "payload" => %{
        "buttons" => [
          %{"payload" => "search_id", "title" => "id", "type" => "postback"},
          %{"payload" => "search_name", "title" => "name", "type" => "postback"}
        ],
        "template_type" => "button",
        "text" => "Welcome Vijaylakshmi to Gecko coin Chat Bot!\n Do you want Search by Coin Id or Coin Name?"
      },
      "type" => "template"
    }
  },
  "recipient" => %{"id" => "6597496056934038"}
}


    test "prepare_button" do
      assert Mindchat.ButtonTemplate.prepare_button({"postback","id","search_id"}) == @prepare_button
    end

    test "attachment" do
      assert Mindchat.ButtonTemplate.attachment("postback","search_id") == @attachment
    end

    test "template" do
      assert Mindchat.ButtonTemplate.template(%{"id" => "6597496056934038"},@message) == @template
    end

end
