defmodule UserAuthWeb.Router do
  use UserAuthWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug, schema: UserAuthWeb.Schema

    unless Mix.env() == :prod do
      forward "/graphiql/user", Absinthe.Plug.GraphiQL,
        schema: UserAuthWeb.Schema,
        interface: :simple
    end
  end
end
