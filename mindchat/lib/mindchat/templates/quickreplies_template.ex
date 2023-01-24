defmodule Mindchat.QuickRepliesTemplate do
alias Mindchat.Message
@compile if Mix.env == :test, do: :export_all
@moduledoc """
json for Quick replies is constructed here
"""

  def replies(event, template_title, replies) do
      replies = Enum.map(replies, &prepare_replies/1)
      message = %{
      "text" => template_title,
      "quick_replies" => replies
      }
      recipient = recipient(event)
      template(recipient, message)
  end

  defp prepare_replies({title, payload}) do
      %{
      "content_type"=> "text",
      "title" => title,
      "payload" => payload
      }
  end

  def recipient(event) do
      %{"id" => Message.get_sender(event)["id"]}
  end

  defp template(recipient, message) do
      %{
      "message" => message,
      "messaging_type"=> "RESPONSE",
      "recipient" => recipient
      }
  end

end
