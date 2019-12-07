defmodule UserAuth do
  @moduledoc """
  UserAuth keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias UserAuth.{Repo, User}

  def create_user(params) when is_map(params) do
    case insert_user(params) do
      {:ok, _} = user ->
        user

      {:error, %Ecto.Changeset{errors: errs}} ->
        {:error, errs}
    end
  end

  def create_user(_), do: {:error, :invalidarg}

  def user_login(%{:email => email, :password => password}) do
    case Repo.get_by(User, email: email) do
      %User{:password_hash => hash} = user ->
        if Pbkdf2.verify_pass(password, hash), do: {:ok, user}, else: {:error, :loginfailed}

      _ ->
        {:error, :nouser}
    end
  end

  def user_login(_), do: {:error, :invalidarg}

  defp insert_user(params),
    do:
      %User{}
      |> User.changeset(params)
      |> Repo.insert()
end
