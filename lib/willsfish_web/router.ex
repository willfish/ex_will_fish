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
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
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
end
