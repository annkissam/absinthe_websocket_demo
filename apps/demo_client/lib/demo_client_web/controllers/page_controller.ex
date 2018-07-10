defmodule DemoClientWeb.PageController do
  use DemoClientWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
