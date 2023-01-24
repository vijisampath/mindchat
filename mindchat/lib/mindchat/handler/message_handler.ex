defmodule Mindchat.MessageHandler do
alias Mindchat.{Bot, TextTemplate, ButtonTemplate,GeckoApi,Message}

    defp get_coin_price(event,coinprice) do
        list=for j <- coinprice,do: tl(j)
        coins=Enum.map(list,fn [x]->"#{x}$" end) |> Enum.join("\n")
        message = " Past 14 day price.\nPrice: #{coins}.\n Do you want to start new search?"
        event
        |> ButtonTemplate.buttons(message,[{:postback,"Yes","searchagain"}])
        |> Bot.send_message()
    end

    @doc """
    When the user selects search by coin from quickreplies
    The price of the coin is showed in this callback
    """
     def handle_message(%{"quick_reply" => %{"payload" => "coinid_"<>selected_coin}}, event) do
       case GeckoApi.get_coin_details(selected_coin) do
       {:ok, coinprice} ->
         {:ok, get_coin_price(event,coinprice)}
       {:error, error} ->
         {:error, error}
       end
     end

    def handle_message(_message, event) do
      greetings = Message.greet()
      message =
      """
      #{greetings}    Unknown Message Received :(
      """
      msg_template = TextTemplate.text(event, message)
      Bot.send_message(msg_template)
    end

end
