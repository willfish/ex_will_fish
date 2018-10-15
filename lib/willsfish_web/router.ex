defmodule WillsfishWeb.Router do
  use WillsfishWeb, :router
  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: false
    plug :put_user_token
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WillsfishWeb do
    pipe_through :browser
    coherence_routes()
    get "/", LandingController, :index
  end

  scope "/", WillsfishWeb do
    pipe_through :protected
    coherence_routes :protected
    resources "/chats", ChatController
  end

  defp put_user_token(conn, _) do
    token = if Coherence.logged_in?(conn) do
      Phoenix.Token.sign(
        conn, "user id", Coherence.current_user(conn).id
      )
    else
      ""
    end

    assign(conn, :token, token)
  end
end
