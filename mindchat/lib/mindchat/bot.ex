defmodule Mindchat.Bot do
  @moduledoc """
  HTTP reponse back to messenger is sent in this module
  """
  @doc """
   It verifies the webhook token
  """

  def verify_webhook(params) do
    facebook_chat_bot = Application.get_env(:mindchat, :facebook_chat_bot)
    mode = params["hub.mode"]
    token = params["hub.verify_token"]
    mode == "subscribe" && token == facebook_chat_bot.webhook_verify_token
  end

  @doc """
  Constructs URL to post response back to facebook messenger
  """
  def bot_endpoint() do
    facebook_chat_bot = Application.get_env(:mindchat, :facebook_chat_bot)
    token = facebook_chat_bot.page_access_token
    message_url =facebook_chat_bot.message_url
    base_url = facebook_chat_bot.base_url
    version = facebook_chat_bot.api_version
    token_path = "?access_token=#{token}"
    base_url<>"/"<>version<>"/"<>message_url<>token_path
  end

  @doc """
  Constructs profile URL to post response back to facebook messenger
  """
  def bot_profile_endpoint() do
    facebook_chat_bot = Application.get_env(:mindchat, :facebook_chat_bot)
    token = facebook_chat_bot.page_access_token
    message_url =facebook_chat_bot.profile_url
    base_url = facebook_chat_bot.base_url
    version = facebook_chat_bot.api_version
    token_path = "?access_token=#{token}"
    base_url<>"/"<>version<>"/"<>message_url<>token_path
  end

  @doc """
  Turns map into JSON
  """
  def encode_json(body) do
    body
    |> Poison.encode!
  end


  @doc """
  Sends the http profile request to facebook messenger
  """
  def send_profile(msg_template) do
    endpoint = bot_profile_endpoint()
    response=HTTPoison.post(endpoint,encode_json(msg_template), [{"content-type", "application/json"}])
    IO.inspect(response)
    case response do
      {:ok, _response} ->
      {:ok,"ok"}
      {:error, reason} ->
      {:error,reason}
      end
  end


  @doc """
  Sends HTTP response to facebook messenger
  """
  def send_message(msg_template) do
    endpoint = bot_endpoint()
    response=HTTPoison.post(endpoint,encode_json(msg_template), [{"content-type", "application/json"}])
    case response do
        {:ok, response} ->
        req=response.request
        {:ok,req.body}
        {:error, reason} ->
        {:error,reason}
      end
 end

end
