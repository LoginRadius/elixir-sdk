# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :lr_elixir_demo_server, LrElixirDemoServerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VBfJvmHhfxidK2Y0bTU0XhVJkpl9uqsUxl4FQDaYqO/d0k8GtSbR/r9UoamZKQ4w",
  render_errors: [view: LrElixirDemoServerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LrElixirDemoServer.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure LR Elixir SDK
config :loginradius,
  appname: "<AppName>",
  apikey: "<ApiKey>",
  apisecret: "<ApiSecret>",
  customapidomain: ""

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
