defmodule Mindchat.GeckoApi do
  @moduledoc """
  Documentation for `CoinGeckoApi`.
  This interface is based on version 3 of the api.
  Base URL is "https://api.coingecko.com/api/v3/"
  Also check out CoinGecko api for more information at https://www.coingecko.com/en/api.
  """

  @cg_base_url "https://api.coingecko.com/api/v3/"
  @print_url false

  def get_api(api_path) do
    url = @cg_base_url <> api_path
    if @print_url, do: IO.puts url
    get(url)
  end

  defp get(url) do
    header = [{"User-Agent", "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36"}, {"Connection", "keep-alive"}, {"Accept-Language", "en-US,en;q=0.8,zh-CN;q=0.6,zh;q=0.4,zh-TW;q=0.2"}]
    response = HTTPoison.get!(url, header)
    case response.status_code do
      200 -> {:ok, Poison.decode!(response.body)}
      429 -> {:error, "API Rate Limit exceeded. Please try again after some time or purchase a Coin Gecko subscription."}
      _ -> {:error, "Unknown Error from Coin Gecko API URL: #{url}"}
    end
  end

  def get_api_params(api_path,params \\%{}) do
    query_params = URI.encode_query(params)
    url = @cg_base_url <> api_path <> query_params
    if @print_url, do: IO.puts url
    get(url)
  end

  @doc """
  Ping API
  ## Examples
      iex(1)> CoinGeckoApi.ping
      %{"gecko_says" => "(V3) To the Moon!"}
  """
  def ping do
    get_api("ping")
  end

  @doc """
  List all supported coins id, name and symbol (no pagination required)
  returns a list with objects like this:
  %{"id" => "1", "name" => "coin_name", "symbol" => "coin_symbol"}
  """

  def coins_list do
     get_api("coins/list")
  end

  def coins_list_id do
    case coins_list() do
    {:ok, response} ->
      {:ok, response |> Enum.map(fn x-> {x["id"],x["id"]} end) |> Enum.take(5)}
    {:error, error} ->
      {:error, error}
      end
  end

  def coins_list_name do
  case coins_list() do
  {:ok, response} ->
    {:ok, response  |> Enum.map(fn x-> {x["id"],x["name"]} end) |> Enum.take(5)}
  {:error, error} ->
    {:error, error}
  end
  end

  @doc """
  Get historical market data include price, market cap, and 24h volume (granularity auto)
  """

  def coins_id_market_chart(id \\ "bitcoin", params) do
    get_api_params("coins/" <> id <> "/market_chart?", params)
  end

  def get_coin_list(message) do
    case message do
      "id" -> coins_list_id()
      "name" -> coins_list_name()
        _ -> coins_list_id()
    end
  end

  @doc """
  Get historical market data include price, market cap, and 24h volume (granularity auto)
  """

  def get_coin_details(id) do
  case coins_id_market_chart(id,%{"vs_currency" => "usd", "days" => "14", "interval" => "daily"}) do
  {:ok, response} ->
    {:ok, response["prices"]}
  {:error, error} ->
    {:enoprofile, error}
    end
  end

end
