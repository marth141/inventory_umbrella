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
config :inventory,
  ecto_repos: [Inventory.Repo]

config :inventory_web,
  ecto_repos: [Inventory.Repo],
  generators: [context_app: :inventory]

# Configures the endpoint
config :inventory_web, InventoryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "d/fqGzGsPpAM/oh+E0UEP7WcKPyM+ui+rx7L7u3zBONcarOXC6KfCufZgbQ0QC0y",
  render_errors: [view: InventoryWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Inventory.PubSub,
  live_view: [signing_salt: "aRvig3Lc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :pdf_generator,
  # <-- this program actually does the heavy lifting
  wkhtml_path: "/usr/bin/wkhtmltopdf",
  # <-- only needed for PDF encryption
  pdftk_path: "/usr/bin/pdftk"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
