defmodule Mindchat.FacebookControllerTest do
  use ExUnit.Case
  use MindchatWeb.ConnCase

  @params "hub.mode=subscribe&hub.verify_token=mindchattoken&hub.challenge=1158201444"

  describe "webhook verify" do
    test "verify webhook", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :verify_webhooks_token), @coindetail)
      #assert json_response(conn, 200)
    end

    test "web hook verification fails", %{conn: conn} do
       conn = post(conn, Routes.facebook_path(conn, :verify_webhooks_token), @coindetail)
       assert json_response(conn, 404)
    end
    end
end
