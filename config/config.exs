# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :willsfish, Willsfish.Robot,
  adapter: Hedwig.Adapters.Console,
  name: "WillBot",
  aka: "/",
  responders: [
    {Hedwig.Responders.Help, []},
    {Hedwig.Responders.Ping, []}
  ]


# General application configuration
config :willsfish,
  ecto_repos: [Willsfish.Repo]

# Configures the endpoint
config :willsfish, WillsfishWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ddhQ8vni9esf+uzIa2ydyeYDQ4g/JtV+SjbHXqX6FMdQBM9y/BEK8z2YmFZ4UnL2",
  render_errors: [view: WillsfishWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Willsfish.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: Willsfish.Coherence.User,
  repo: Willsfish.Repo,
  module: Willsfish,
  web_module: WillsfishWeb,
  router: WillsfishWeb.Router,
  messages_backend: WillsfishWeb.Coherence.Messages,
  logged_out_url: "/sessions/new",
  registration_permitted_attributes: ["email","name","password","current_password","password_confirmation"],
  invitation_permitted_attributes: ["name","email"],
  password_reset_permitted_attributes: ["reset_password_token","password","password_confirmation"],
  session_permitted_attributes: ["remember","email","password"],
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, WillsfishWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
