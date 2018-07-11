defmodule DemoServerWeb.Router do
  use DemoServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DemoServerWeb do
    pipe_through :browser # Use the default browser stack

    resources "/employees", EmployeeController

    get "/", PageController, :index
  end

  if Mix.env == :dev do
    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: DemoServerQL.Schema,
      socket: DemoServerWeb.UserSocket,
      interface: :advanced
  end

  scope "/api" do
    pipe_through [:api]

    forward "/", Absinthe.Plug,
      schema: DemoServerQL.Schema
  end

  # Other scopes may use custom stacks.
  # scope "/api", DemoServerWeb do
  #   pipe_through :api
  # end
end
