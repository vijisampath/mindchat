defmodule MindchatWeb.FacebookController do
alias Mindchat.{Bot, WelcomeTemplate, Mindchatbot}
  use MindchatWeb, :controller

  @doc """
    One time facebook messenger webhook token verification code with
    facebook webhook verify token(private key) and a challenge code
  """

  def verify_webhooks_token(conn, params) do
    verified? = Bot.verify_webhook(params)

    if verified? do
      conn
        |> put_resp_content_type("text/plain")
        |> resp(200, params["hub.challenge"])
        |> send_resp()
      else
        conn
        |> put_resp_content_type("application/json")
        |> resp(403, Jason.encode!(%{status: "error", message: "unauthorized"}))
    end

    case  WelcomeTemplate.welcome()|> Bot.send_profile() do
        {:ok, response} -> conn |> put_resp_content_type("application/json")|> put_status(200)|> json(%{success: "ok"})
        {:error, error} ->conn |> put_resp_content_type("application/json") |>put_status(404)|>  json( %{errors: error})
    end

    case  WelcomeTemplate.greeting() |> Bot.send_profile() do
        {:ok, response} -> conn |> put_resp_content_type("application/json")|> put_status(200)|> json(%{success: "ok"})
        {:error, error} ->conn |> put_resp_content_type("application/json") |>put_status(404)|>  json( %{errors: error})
    end
  end


    @doc """
      Facebook messenger communicates with mindchat server using this controller
    """

  def handle_event(conn, event_data) do
    case Mindchat.Mindchatbot.handle_event(event_data) do
      {:ok, response} -> conn |> put_resp_content_type("application/json")|> put_status(200)|> json(%{success: "ok"})
    {:error, error} ->conn |> put_resp_content_type("application/json") |>put_status(404)|>  json( %{errors: error})
    end
  end

end
