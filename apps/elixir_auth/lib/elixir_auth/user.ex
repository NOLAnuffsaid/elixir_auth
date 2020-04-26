defmodule UserAuth.User do
  use Ecto.Schema

  alias UserAuth.User

  import Ecto.Changeset

  @moduledoc """
  Schema to define a user struct
  """

  schema "users" do
    field(:email, :string)
    field(:password_hash, :string)
    field(:name, :string)
  end

  def changeset(%User{} = user, %{password: password} = params)
      when is_binary(password) and bit_size(password) > 0,
      do:
        user
        |> cast(params, [:email, :name], [])
        |> put_hashed_password(password)
        |> validate_required([:email, :password_hash])
        |> validate_format(:email, ~r/\S@\w.\w/)
        |> unique_constraint(:email)

  def changeset(%User{} = user, _),
    do:
      user
      |> change()
      |> add_error(:password_hash, "password required")

  def changeset(_, _), do: {:error, :invalidargs}

  defp put_hashed_password(
         %Ecto.Changeset{valid?: true} = changeset,
         password
       ),
       do: put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(password))

  defp put_hashed_password(changeset, _), do: changeset
end
