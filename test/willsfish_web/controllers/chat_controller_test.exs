defmodule WillsfishWeb.ChatControllerTest do
  use WillsfishWeb.ConnCase

  alias Willsfish.Communication

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:chat) do
    {:ok, chat} = Communication.create_chat(@create_attrs)
    chat
  end

  describe "index" do
    test "lists all chats", %{conn: conn} do
      conn = get conn, chat_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Chats"
    end
  end

  describe "new chat" do
    test "renders form", %{conn: conn} do
      conn = get conn, chat_path(conn, :new)
      assert html_response(conn, 200) =~ "New Chat"
    end
  end

  describe "create chat" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, chat_path(conn, :create), chat: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == chat_path(conn, :show, id)

      conn = get conn, chat_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Chat"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, chat_path(conn, :create), chat: @invalid_attrs
      assert html_response(conn, 200) =~ "New Chat"
    end
  end

  describe "edit chat" do
    setup [:create_chat]

    test "renders form for editing chosen chat", %{conn: conn, chat: chat} do
      conn = get conn, chat_path(conn, :edit, chat)
      assert html_response(conn, 200) =~ "Edit Chat"
    end
  end

  describe "update chat" do
    setup [:create_chat]

    test "redirects when data is valid", %{conn: conn, chat: chat} do
      conn = put conn, chat_path(conn, :update, chat), chat: @update_attrs
      assert redirected_to(conn) == chat_path(conn, :show, chat)

      conn = get conn, chat_path(conn, :show, chat)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, chat: chat} do
      conn = put conn, chat_path(conn, :update, chat), chat: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Chat"
    end
  end

  describe "delete chat" do
    setup [:create_chat]

    test "deletes chosen chat", %{conn: conn, chat: chat} do
      conn = delete conn, chat_path(conn, :delete, chat)
      assert redirected_to(conn) == chat_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, chat_path(conn, :show, chat)
      end
    end
  end

  defp create_chat(_) do
    chat = fixture(:chat)
    {:ok, chat: chat}
  end
end
