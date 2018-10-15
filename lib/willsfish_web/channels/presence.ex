defmodule WillsfishWeb.Presence do
  use Phoenix.Presence, otp_app: :willsfish,
                        pubsub_server: Willsfish.PubSub
end
