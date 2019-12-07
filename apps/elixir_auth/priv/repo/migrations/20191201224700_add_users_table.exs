defmodule UserAuth.Repo.Migrations.AddUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, size: 50, null: false
      add :password_hash, :binary, null: false
      add :name, :string, size: 40
    end

    create unique_index(:users, [:email])
  end
end
