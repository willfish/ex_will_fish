defmodule WillsfishWeb.LandingController do
  use WillsfishWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
