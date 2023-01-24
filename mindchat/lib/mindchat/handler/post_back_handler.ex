defmodule Mindchat.PostBackHandler do
alias Mindchat.{Bot, TextTemplate, ButtonTemplate,GeckoApi, Message, QuickRepliesTemplate}
@moduledoc """
postback calls from facebook messenger are handled here
"""

  @doc """
  When user clicks the get started button on chat window, this callback is invoked
  It displays a button to allow user to search by coin id or coin name
  """
  def handle_postback(%{"payload" => "welcome"}, event) do
        IO.puts("Postback Received")
        case Message.get_profile(event) do
          {:ok, profile} ->fetch_name(event,profile)
          {:error,error} ->{:error, error}
        end
  end

  #After price of coin is viewed. The user is prompted to start search again
  def handle_postback(%{"payload" => "searchagain"}, event) do
        template_title = "Do you want search by coin id or coin name?"
        process_option(event,%{"id"=>"search_id","name"=>"search_name"},template_title)
  end

  #When the user selects search by coin name or id, this postback is called
  #This lists 5 coins by name or id

  def handle_postback(%{"payload" => "search_" <> selected_search}, event) do
      case GeckoApi.get_coin_list(selected_search) do
      {:ok, coinlist} ->
        {:ok, get_coins(event,coinlist)}
      {:error, error} ->
        {:error, error}
      end
  end

  #  When the user selects search by coin from quickreplies
  #  The price of the coin is showed in this callback
  def handle_postback(%{"payload" => "coinid_" <> selected_coin}, event) do
      case GeckoApi.get_coin_details(selected_coin) do
      {:ok, coinprice} ->
        {:ok, get_coin_price(event,coinprice)}
      {:error, error} ->
        {:error, error}
      end
  end
  # When unknown postback is called by mistake, its handled here
  def handle_postback(_message, event) do
    greetings = Message.greet()
    message =
    """
    #{greetings}    Unknown Message Received :(
    """
    msg_template = TextTemplate.text(event, message)
    Bot.send_message(msg_template)
    {:error,msg_template}
  end

  defp get_coins(event,coinlist) do
      template_title = "Select the coin to get its price"
      coinmap=Enum.map(coinlist,fn {x,y}->{y,"coinid_"<>x} end)
      resp_template=QuickRepliesTemplate.replies(event, template_title, coinmap)
      Bot.send_message(resp_template)
  end

  defp fetch_name(event,profile) do
      {:ok, first_name} = Map.fetch(profile, "first_name")
      template_title = "Welcome #{first_name} to Gecko coin chat bot!\n Do you want search by coin id or coin name?"
      process_option(event,%{"id"=>"search_id","name"=>"search_name"},template_title)
  end

  defp get_coin_price(event,coinprice) do
      list=for j <- coinprice,do: tl(j)
      coins=Enum.map(list,fn [x]->"#{x}$" end) |> Enum.join("\n")
      message = " Past 14 day Price.Price: #{coins}.\n Do you want to start new search?"
      event
      |> ButtonTemplate.buttons(message,[{:postback,"Yes","searchagain"}])
      |> Bot.send_message()

  end

  defp process_option(event,coinmap,template_title) do
    resp_template=request_options(event,coinmap,template_title)
    Bot.send_message(resp_template)
  end

  defp request_options(event,options,template_title) do
    buttons=Enum.map(options,fn {x,y}->{:postback,x,y} end)
    ButtonTemplate.buttons(event, template_title, buttons)
  end
end
