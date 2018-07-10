# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :demo_server,
  namespace: DemoServer,
  ecto_repos: [DemoServer.Repo]

# Configures the endpoint
config :demo_server, DemoServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/jcZGhCgT9vGXbdPYA9/49I00GmFR1YUttbMhMli/sn6j5t5/nknJhh0rq0PN71n",
  render_errors: [view: DemoServerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: DemoServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
