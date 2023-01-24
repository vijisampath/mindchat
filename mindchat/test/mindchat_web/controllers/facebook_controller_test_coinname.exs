defmodule Mindchat.FacebookControllerTest do
  use ExUnit.Case
  use MindchatWeb.ConnCase

  @result "ok"
  @error2  %{"message" => %{"text" => "Hello buddy :)\nWelcome to Mindchat\n    Unknown Message Received :(\n"}, "recipient" => %{"id" => "6597496056934038"}}
  @error1 "Facebook graph API changed"
  @coinname %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "search_name"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
    describe "Show selection option on clicking search by coin name button when parameters valid" do
      test "Show selection option", %{conn: conn} do
        conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinname)
        assert json_response(conn, 200)["success"] == @result
     end
    end

    @coinnameError1  %{"entry" => [%{"messag" => [%{"postback" => %{"payload" => "search_name"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coinnameError2 %{"entry" => [%{"messaging" => [%{"postck" => %{"payload" => "search_name"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coinnameError3 %{"entry" => [%{"messaging" => [%{"postback" => %{"payoad" => "search_name"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
  @coinnameError4 %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "serch_name"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}

  describe "Show error on clicking search by name button when parameters are invalid" do

    test "Show error on clicking search by name button when messaging parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinnameError1)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error on clicking search by name button when postback parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinnameError2)
      assert json_response(conn,404)["errors"] == @error1
   end

    test "Show error on clicking search by name button when payload parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinnameError3)
      assert json_response(conn,404)["errors"] == @error2
    end


    test "Show error on clicking search by name button when welcome parameters is invalid", %{conn: conn} do
      conn = post(conn, Routes.facebook_path(conn, :handle_event), @coinnameError4)
      assert json_response(conn,404)["errors"] == @error2
   end
  end
  end
