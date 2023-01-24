defmodule Mindchat.Mindchatbot do
  alias Mindchat.{Message, MessageHandler, PostBackHandler}

    @doc """
      Message and postback from facebook messenger actions gets filtered here
      and corresponding methods are called
    """

   def handle_event(event) do
    case Message.get_messaging(event) do
      %{"message" => message} ->
        MessageHandler.handle_message(message , event)
      %{"postback" => message} ->
        PostBackHandler.handle_postback(message , event)
      _ ->
        {:error,"Facebook graph API changed"}
    end
  end
  
end
