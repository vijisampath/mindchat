defmodule Mindchat.FacebookControllerTest do
  use ExUnit.Case
  use MindchatWeb.ConnCase

  @result "ok"
  @error2  %{"message" => %{"text" => "Hello buddy :)\nWelcome to Mindchat\n    Unknown Message Received :(\n"}, "recipient" => %{"id" => "6597496056934038"}}
  @error1 "Facebook graph API changed"

  @welcome %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "welcome"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  describe "Show selection option on clicking get started button when parameters valid" do
    test "Show selection option", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @welcome)
      assert json_response(conn, 200)["success"] == @result
   end
  end

  @welcomeError1  %{"entry" => [%{"messag" => [%{"postback" => %{"payload" => "welcome"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @welcomeError2 %{"entry" => [%{"messaging" => [%{"postck" => %{"payload" => "welcome"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @welcomeError3 %{"entry" => [%{"messaging" => [%{"postback" => %{"payoad" => "welcome"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @welcomeError5 %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "welme"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}

  describe "Show error on clicking get started button when parameters are invalid" do

    test "Show error when messaging parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @welcomeError1)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error when postback parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @welcomeError2)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error when payload parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @welcomeError3)
      assert json_response(conn,404)["errors"] == @error2
    end

    test "Show error when welcome parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @welcomeError5)
      assert json_response(conn,404)["errors"] == @error2
   end
end

end
