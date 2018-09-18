defmodule Willsfish.CommunicationTest do
  use Willsfish.DataCase

  alias Willsfish.Communication

  describe "chats" do
    alias Willsfish.Communication.Chat

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def chat_fixture(attrs \\ %{}) do
      {:ok, chat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Communication.create_chat()

      chat
    end

    test "list_chats/0 returns all chats" do
      chat = chat_fixture()
      assert Communication.list_chats() == [chat]
    end

    test "get_chat!/1 returns the chat with given id" do
      chat = chat_fixture()
      assert Communication.get_chat!(chat.id) == chat
    end

    test "create_chat/1 with valid data creates a chat" do
      assert {:ok, %Chat{} = chat} = Communication.create_chat(@valid_attrs)
    end

    test "create_chat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Communication.create_chat(@invalid_attrs)
    end

    test "update_chat/2 with valid data updates the chat" do
      chat = chat_fixture()
      assert {:ok, chat} = Communication.update_chat(chat, @update_attrs)
      assert %Chat{} = chat
    end

    test "update_chat/2 with invalid data returns error changeset" do
      chat = chat_fixture()
      assert {:error, %Ecto.Changeset{}} = Communication.update_chat(chat, @invalid_attrs)
      assert chat == Communication.get_chat!(chat.id)
    end

    test "delete_chat/1 deletes the chat" do
      chat = chat_fixture()
      assert {:ok, %Chat{}} = Communication.delete_chat(chat)
      assert_raise Ecto.NoResultsError, fn -> Communication.get_chat!(chat.id) end
    end

    test "change_chat/1 returns a chat changeset" do
      chat = chat_fixture()
      assert %Ecto.Changeset{} = Communication.change_chat(chat)
    end
  end
end
