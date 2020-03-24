defmodule UserAuthWeb.Resolvers do
  require Logger

  @moduledoc false

  def create_user(_, %{user_params: %{email: _, password: _} = params}, _),
    do:
      params
      |> UserAuth.create_user()
      |> handle_create_error()

  def create_user(_, _, _),
    do: {:error, :invalidargs}

  def user_login(_, %{user_params: %{email: _, password: _} = params}, _),
    do:
      params
      |> UserAuth.user_login()
      |> handle_login_error()

  def user_login(_, _, _),
    do: {:error, :invalidargs}

  defp handle_create_error({:ok, _} = result), do: result
  defp handle_create_error(error), do: error

  defp handle_login_error({:ok, _} = result), do: result
  defp handle_login_error({:error, _err} = errors), do: errors
end
