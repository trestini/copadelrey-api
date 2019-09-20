defmodule CupWeb.PageController do
  use CupWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
