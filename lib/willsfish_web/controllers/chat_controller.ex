defmodule WillsfishWeb.ChatController do
  use WillsfishWeb, :controller

  alias Willsfish.Communication
  alias Willsfish.Communication.Chat

  def index(conn, _params) do
    chats = Communication.list_chats()
    render(conn, "index.html", chats: chats)
  end

  def new(conn, _params) do
    changeset = Communication.change_chat(%Chat{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"chat" => chat_params}) do
    case Communication.create_chat(chat_params) do
      {:ok, chat} ->
        conn
        |> put_flash(:info, "Chat created successfully.")
        |> redirect(to: chat_path(conn, :show, chat))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    chat = Communication.get_chat!(id)
    render(conn, "show.html", chat: chat)
  end

  def edit(conn, %{"id" => id}) do
    chat = Communication.get_chat!(id)
    changeset = Communication.change_chat(chat)
    render(conn, "edit.html", chat: chat, changeset: changeset)
  end

  def update(conn, %{"id" => id, "chat" => chat_params}) do
    chat = Communication.get_chat!(id)

    case Communication.update_chat(chat, chat_params) do
      {:ok, chat} ->
        conn
        |> put_flash(:info, "Chat updated successfully.")
        |> redirect(to: chat_path(conn, :show, chat))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", chat: chat, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    chat = Communication.get_chat!(id)
    {:ok, _chat} = Communication.delete_chat(chat)

    conn
    |> put_flash(:info, "Chat deleted successfully.")
    |> redirect(to: chat_path(conn, :index))
  end
end
