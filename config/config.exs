# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :elixir_auth,
  namespace: UserAuth,
  ecto_repos: [UserAuth.Repo]

config :elixir_auth_web,
  namespace: UserAuthWeb,
  ecto_repos: [UserAuth.Repo],
  generators: [context_app: :elixir_auth]

# Configures the endpoint
config :elixir_auth_web, UserAuthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("APP_SECRET"),
  render_errors: [view: UserAuthWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: UserAuthWeb.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
