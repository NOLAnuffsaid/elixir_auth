defmodule UserAuthWeb.Schema do
  use Absinthe.Schema

  import_types(UserAuthWeb.Schema.DataTypes)

  @moduledoc false

  @desc "User params expected by our API"
  input_object :user_params do
    field(:email, non_null(:string))
    field(:password, non_null(:string))
    field(:name, :string)
  end

  query do
    @desc "Login info used to identify a guests access to user info"
    field :user_login, :user do
      arg(:user_params, non_null(:user_params))
      resolve(&UserAuthWeb.Resolvers.user_login/3)
    end
  end

  mutation do
    @desc "Params used to create new users"
    field :create_user, :user do
      arg(:user_params, non_null(:user_params))
      resolve(&UserAuthWeb.Resolvers.create_user/3)
    end
  end
end
