# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :lr_elixir_demo_server,
  ecto_repos: [LrElixirDemoServer.Repo]

# Configures the endpoint
config :lr_elixir_demo_server, LrElixirDemoServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "E1XAbMWqJxzBGOOXC13T8YKVBWKDEg+rxft544SNph+ivImwiklgidId+wrQgItJ",
  render_errors: [view: LrElixirDemoServerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LrElixirDemoServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Configure LR Elixir SDK
config :loginradius_elixir_sdk,
  appname: "<AppName>",
  apikey: "<ApiKey>",
  apisecret: "<ApiSecret>"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
