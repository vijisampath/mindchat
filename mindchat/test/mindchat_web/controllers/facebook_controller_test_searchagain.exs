defmodule Mindchat.FacebookControllerTest do
  use ExUnit.Case
  use MindchatWeb.ConnCase

  @result "ok"
  @error2  %{"message" => %{"text" => "Hello buddy :)\nWelcome to Mindchat\n    Unknown Message Received :(\n"}, "recipient" => %{"id" => "6597496056934038"}}
  @error1 "Facebook graph API changed"
@searchagain %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "searchagain"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  describe "Show selection option on clicking get started button when parameters valid" do
    test "Show selection option", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @searchagain)
      assert json_response(conn, 200)["success"] == @result
   end
  end

  @searchagainError1  %{"entry" => [%{"messag" => [%{"postback" => %{"payload" => "searchagain"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @searchagainError2 %{"entry" => [%{"messaging" => [%{"postck" => %{"payload" => "searchagain"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @searchagainError3 %{"entry" => [%{"messaging" => [%{"postback" => %{"payoad" => "searchagain"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @searchagainError4 %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "srchagain"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}

  describe "Show error on clicking searchagain button when parameters are invalid" do

    test "Show error on clicking searchagain button when messaging parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @searchagainError1)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error on clicking searchagain button when postback parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @searchagainError2)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error on clicking searchagain button when payload parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @searchagainError3)
      assert json_response(conn,404)["errors"] == @error2
    end


    test "Show error on clicking searchagain button when welcome parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @searchagainError4)
      assert json_response(conn,404)["errors"] == @error2
   end
end
end
