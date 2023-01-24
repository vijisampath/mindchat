defmodule Mindchat.ButtonTemplate do
alias Mindchat.Message
@compile if Mix.env == :test, do: :export_all
@moduledoc """
json for button template  response to messenger is constructed here
"""

  def buttons(event, template_title, buttons) do
        buttons = Enum.map(buttons, &prepare_button/1)
        payload = %{
        "template_type" => "button",
        "text" => template_title,
        "buttons" => buttons
        }
        recipient = recipient(event)
        message = %{
        "attachment" => attachment("template", payload)
        }
        template(recipient, message)
  end

  def prepare_button({message_type, title, payload}) do
      %{
      "type" => "#{message_type}",
      "title" => title,
      "payload" => payload
      }
  end

  defp recipient(event) do
      %{"id" => Message.get_sender(event)["id"]}
  end


  defp attachment(type, payload) do
      %{
      "type" => type,
      "payload" => payload
      }
  end

  defp template(recipient, message) do
      %{
      "message" => message,
      "recipient" => recipient
      }
  end

end
