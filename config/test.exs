use Mix.Config

# Configure your database
config :elixir_auth, UserAuth.Repo,
  username: System.get_env("ELIXIR_DB_USER"),
  password: System.get_env("DB_PW"),
  database: "elixir_auth_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixir_auth_web, UserAuthWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :pbkdf2_elixir, :rounds, 1

config :junit_formatter,
  report_file: "report_file_test.xml",
  report_dir: "../../tmp",
  print_report_file: true,
  prepend_project_name?: true,
  include_filename?: true
