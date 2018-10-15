defmodule WillsfishWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "room", WillsfishWeb.RoomChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(%{"token" => user_id}, socket) do
    if authorized?(socket, user_id) do
      {:ok, socket}
    else
      :error
    end
  end

  def id(_socket), do: nil

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
