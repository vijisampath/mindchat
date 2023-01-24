defmodule Mindchat.FacebookControllerTest do
  use ExUnit.Case
  use MindchatWeb.ConnCase

  @result "ok"
  @error2  %{"message" => %{"text" => "Hello buddy :)\nWelcome to Mindchat\n    Unknown Message Received :(\n"}, "recipient" => %{"id" => "6597496056934038"}}
  @error1 "Facebook graph API changed"

@coinid %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "search_id"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  describe "Show selection option on clicking search id button when parameters valid" do
    test "Show selection option", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinid)
      assert json_response(conn, 200)["success"] == @result
   end
  end


  @coinidError1  %{"entry" => [%{"messag" => [%{"postback" => %{"payload" => "search_id"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coinidError2 %{"entry" => [%{"messaging" => [%{"postck" => %{"payload" => "search_id"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coinidError3 %{"entry" => [%{"messaging" => [%{"postback" => %{"payoad" => "search_id"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coinidError4 %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "seach_id"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}

  describe "Clicking search id button-invalid cases:" do

    test "Show error on clicking search id when messaging parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinidError1)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error on clicking search id  when postback parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinidError2)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error on clicking search id when payload parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinidError3)
      assert json_response(conn,404)["errors"] == @error2
    end


    test "Show error on clicking search id when searchid parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinidError4)
      assert json_response(conn,404)["errors"] == @error2
   end
end
end
