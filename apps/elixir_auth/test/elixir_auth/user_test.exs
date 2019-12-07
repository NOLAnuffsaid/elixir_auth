defmodule UserAuth.UserTest do
  use UserAuth.DataCase, async: true

  alias UserAuth.User

  describe "User" do
    test "should create valid changeset" do
      params = %{
        :email => Faker.Internet.email(),
        :password => Faker.String.base64(),
        :name => Faker.Name.name()
      }

      user = %User{} |> User.changeset(params)
      assert(user.valid?)
    end

    test "should create valid changeset with missing name attribute" do
      params = %{
        :email => Faker.Internet.email(),
        :password => Faker.String.base64()
      }

      user = %User{} |> User.changeset(params)
      assert(user.valid?)
    end

    test "should create changeset with errors for email" do
      params = %{:email => "", :password => Faker.String.base64(), :name => Faker.Name.name()}

      user = %User{} |> User.changeset(params)
      refute(user.valid?)
    end

    test "should create changeset with errors for password" do
      params = %{:email => Faker.Internet.email(), :password => "", :name => Faker.Name.name()}

      user = %User{} |> User.changeset(params)
      refute(user.valid?)
    end

    test "should not duplicate accounts based on email address" do
      params = %{:email => Faker.Internet.email(), :password => Faker.String.base64()}
      dup_params = Map.merge(params, %{:name => Faker.Superhero.name()})

      UserAuth.create_user(params)

      assert {:error, _} = UserAuth.create_user(dup_params)
    end
  end
end
