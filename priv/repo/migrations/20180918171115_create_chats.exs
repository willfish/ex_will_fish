defmodule Willsfish.Repo.Migrations.CreateChats do
  use Ecto.Migration

  def change do
    create table(:chats) do

      timestamps()
    end

  end
end
