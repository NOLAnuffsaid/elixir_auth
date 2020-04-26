defmodule UserAuthTest do
  use UserAuth.DataCase, async: true
  use ExUnitProperties

  @hosts ["yourmail", "talkbox", "mailhub"]
  @domains ["com", "net", "org"]

  describe "valid params" do
    property " will successfully create an account" do
      check all(
              email <- gen_email(),
              name <- StreamData.string(:alphanumeric, max_length: 20),
              password <- StreamData.string(:alphanumeric, min_length: 5, max_length: 20),
              password != ""
            ) do
        params = %{email: email, password: password, name: name}
        assert {:ok, _} = params |> UserAuth.create_user()
      end
    end
  end

  test "should successfully login when valid credentials are given" do
    params = %{email: Faker.Internet.email(), password: Faker.String.base64()}
    UserAuth.create_user(params)

    assert {:ok, _} = UserAuth.user_login(params)
  end

  test "should fail login when invalid credentials are given" do
    params = %{email: Faker.Internet.email(), password: Faker.String.base64()}
    UserAuth.create_user(params)

    assert {:error, _} =
             UserAuth.user_login(%{
               email: Map.fetch!(params, :email),
               password: Faker.Pokemon.name()
             })
  end

  defp gen_email do
    gen all(
          user <- StreamData.string(:alphanumeric, min_length: 2, max_length: 20),
          host <- StreamData.member_of(@hosts),
          domain <- StreamData.member_of(@domains)
        ) do
      "#{user}@#{host}.#{domain}"
    end
  end
end
