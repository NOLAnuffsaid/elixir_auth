ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(UserAuth.Repo, :manual)
Application.ensure_all_started(:wallaby)
