defmodule UserAuthWeb.Schema.DataTypes do
  use Absinthe.Schema.Notation

  @moduledoc false

  object :user do
    field(:id, :id)
    field(:name, :string)
    field(:email, :string)
  end
end
