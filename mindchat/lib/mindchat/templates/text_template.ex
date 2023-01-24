defmodule Mindchat.TextTemplate do
alias Mindchat.Message

  def text(event, text) do
      %{
      "recipient" => recipient(event),
      "message" => %{"text" => text }
      }
  end

  defp recipient(event) do
      %{"id" => Message.get_sender(event)["id"]}
end

end
