defmodule Mindchat.FacebookControllerTest do
  use ExUnit.Case
  use MindchatWeb.ConnCase


    @welcome %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "welcome"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
    @coinid %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "search_id"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
    @coinname %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "search_name"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
    @coindetail %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "coinid_bitcoin"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
    @searchagain %{"entry" => [%{"messaging" => [%{"postback" => %{"payload" => "searchagain"}, "sender" => %{"id" => "6597496056934038"}}]}], "object" => "page"}
    test "test sequence of actions-1" , %{conn: conn}do
      Enum.each([
      post(conn, Routes.facebook_path(conn, :handle_event), @welcome),
      post(conn, Routes.facebook_path(conn, :handle_event), @coinid),
      post(conn, Routes.facebook_path(conn, :handle_event), @coindetail),
      post(conn, Routes.facebook_path(conn, :handle_event), @searchagain),
      ],
      fn conn ->
      assert json_response(conn, 200)
       end)
    end



    test "test sequence of actions-3", %{conn: conn}do
      Enum.each([
      post(conn, Routes.facebook_path(conn, :handle_event), @welcome),
      post(conn, Routes.facebook_path(conn, :handle_event), @coinname),
      post(conn, Routes.facebook_path(conn, :handle_event), @coindetail),
      post(conn, Routes.facebook_path(conn, :handle_event), @coinid),
      post(conn, Routes.facebook_path(conn, :handle_event), @coindetail),
      post(conn, Routes.facebook_path(conn, :handle_event), @searchagain),
      ],
      fn conn ->
      assert json_response(conn, 200)
       end)
    end




end
