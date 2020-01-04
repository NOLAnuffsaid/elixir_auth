defmodule UserAuthWeb.ApiController do
  use UserAuthWeb, :controller

  def user(conn, _), do: json(conn, :ok)
end
