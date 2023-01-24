defmodule Mindchat.FacebookControllerTest do
  use ExUnit.Case
  use MindchatWeb.ConnCase

  @result "ok"
  @error2  %{"message" => %{"text" => "Hello buddy :)\nWelcome to Mindchat\n    Unknown Message Received :(\n"}, "recipient" => %{"id" => "6597496056934038"}}
  @error1 "Facebook graph API changed"

@coindetail %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "coinid_bitcoin"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  describe "Show selection option on clicking get started button when parameters valid" do
    test "Show selection option", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coindetail)
      assert json_response(conn, 200)["success"] == @result
   end
  end

  @coindetailError1  %{"entry" => [%{"messag" => [%{"postback" => %{"payload" => "coinid_bitcoin"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coindetailError2 %{"entry" => [%{"messaging" => [%{"postck" => %{"payload" => "coinid_bitcoin"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coindetailError3 %{"entry" => [%{"messaging" => [%{"postback" => %{"payoad" => "coinid_bitcoin"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coindetailError4 %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "coind_bitcoin"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}

  describe "Show error on clicking coin button when parameters are invalid" do

    test "Show error on clicking coin button when messaging parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coindetailError1)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error on clicking coin button when postback parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coindetailError2)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error on clicking coin button when payload parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coindetailError3)
      assert json_response(conn,404)["errors"] == @error2
    end


    test "Show error on clicking coin button when welcome parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coindetailError4)
      assert json_response(conn,404)["errors"] == @error2
   end
end
end
