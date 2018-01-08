defmodule GodeliverWeb.PageController do
  use GodeliverWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
