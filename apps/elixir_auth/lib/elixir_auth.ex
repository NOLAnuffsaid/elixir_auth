defmodule UserAuth do
  @moduledoc """
  UserAuth keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  import Ecto.Query

  alias UserAuth.{Repo, User}

  def create_user(params)
    when is_map(params),
    do:
      params
      |> insert_user()
      |> handle_insert_error()

  def create_user(_),
    do: {:error, :invalidarg}

  defp insert_user(params),
    do:
      %User{}
      |> User.changeset(params)
      |> Repo.insert(log: false)

  defp handle_insert_error({:ok, _} = user),
    do: user

  defp handle_insert_error({:error, %Ecto.Changeset{errors: errs} = chst}),
    do: {:error, sanitize_errors(errs)}

  defp sanitize_errors(errors),
    do:
      Enum.reduce(errors, [], fn
        {key, {str, _}}, acc ->
          str_key = Atom.to_string(key)
          acc ++ ["#{str_key} - #{str}"]
      end)

  def user_login(%{:email => email, :password => password})
    when byte_size(password) > 0,
    do:
      User
      |> Repo.get_by([email: email], log: false)
      |> verify_password(password)

  def user_login(_),
    do: {:error, :invalidarg}

  defp verify_password(%User{:password_hash => hash} = user, password),
    do:
      password
      |> Pbkdf2.verify_pass(hash)
      |> handle_login_failure(user)

  defp verify_password(_, _),
    do: {:error, :nouser}

  defp handle_login_failure(true, user),
    do: {:ok, user}

  defp handle_login_failure(_, _),
    do: {:error, :loginfailed}
end
