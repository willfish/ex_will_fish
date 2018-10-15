defmodule WillsfishWeb.RoomChannel do
  use WillsfishWeb, :channel
  alias WillsfishWeb.Presence

  def join("room", payload, socket) do
    if authorized?(socket, payload["token"]) do
      send(self(), {:after_join, payload})
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("message:new", payload, socket) do
    broadcast! socket, "message:new", %{user: payload["user"],
                                    message: payload["message"]}
    {:noreply, socket}
  end

  def handle_info({:after_join, payload}, socket) do
    {:ok, identifier} = verify(socket, payload["token"])
    user = Willsfish.Coherence.Schemas.get_user(identifier)
    {:ok, _} = Presence.track(socket, user.name, %{
      online_at: inspect(System.system_time(:seconds))
    })
    push socket, "presence_state", Presence.list(socket)
    {:noreply, socket}
  end

  defp authorized?(socket, token) do
    case verify(socket, token) do
      {:ok, _identifier} -> true
      {:error, _reason} -> false
    end
  end

  defp verify(socket, token) do
    Phoenix.Token.verify(
      socket,
      "user id",
      token,
      max_age: 1000000
    )
  end
end
