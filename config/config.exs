# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :godeliver,
  ecto_repos: [Godeliver.Repo]

# Configures the endpoint
config :godeliver, GodeliverWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BrI21BKVbIYhGygffZI1TlvsUCGzPTI28TfwT3sSsrNNzn1m+hzHbWueChBEqVc0",
  render_errors: [view: GodeliverWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Godeliver.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :godeliver, Godeliver.Customer.Guardian,
  issuer: 'godeliver',
  secret_key: "djy/P48678rVMiaH0ghWO3jbY1b1FGDVwCAstKIhLhBlVjAxanRZmzfTLq8OrERW"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
