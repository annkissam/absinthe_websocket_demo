defmodule DemoServerWeb.PageController do
  use DemoServerWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
