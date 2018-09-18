Willsfish.Repo.delete_all Willsfish.Coherence.User
{name, _} = System.cmd("git", ["config", "user.name"])
name = String.trim(name)
{email, _} = System.cmd("git", ["config", "user.email"])
email = String.trim(email)
changeset = Willsfish.Coherence.User.changeset(
  %Willsfish.Coherence.User{},
  %{
    name: name,
    email: email,
    password: "secret",
    password_confirmation: "secret"
  }
)

Willsfish.Repo.insert!(changeset)
# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Willsfish.Repo.insert!(%Willsfish.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
