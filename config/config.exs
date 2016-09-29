# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ascension_api,
  ecto_repos: [AscensionApi.Repo]

# Configures the endpoint
config :ascension_api, AscensionApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vgLPZ3cSsN0SIuNhJ0pDiP02ENR/bBgwUFoNHA11g6YOP0qygEQ0eZQaxNniTFm1",
  render_errors: [view: AscensionApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AscensionApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :format_encoders,
  "json-api": Poison

config :mime, :types, %{  
  "application/vnd.api+json" => ["json-api"]
}

config :phoenix, AscensionApi.Endpoint,
  render_errors: [view: AscensionApi.ErrorView, accepts: ~w(html json json-api)]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
