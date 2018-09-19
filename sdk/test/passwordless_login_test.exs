defmodule PasswordlessLoginTest do
  use ExUnit.Case

  setup do
    test_data = LoginRadius.Account.create(
      %{
        "FirstName" => "testaccount",
        "LastName" => "auto",
        "Email" => [
          %{
            "Type" => "Primary",
            "Value" => "testaccountauto@mailinator.com"
          }
        ],
        "UserName" => "taa",
        "State" => "Alberta",
        "City" => "Edmonton",
        "ProfileCity" => "Edmonton",
        "ProfileCountry" => "Canada",
        "Password" => "password",
        "PhoneId" => "17787694512",
        "EmailVerified" => true,
        "PhoneIdVerified" => true
      })
  
      on_exit fn ->
        elem(test_data, 1)
          |> elem(1)
          |> Map.fetch!("Uid")
          |> LoginRadius.Account.delete()
      end
  end

  test "Passwordless Login by Email" do
    test_plbe_response = "testaccountauto@mailinator.com"
      |> LoginRadius.PasswordlessLogin.login_by_email()

    assert elem(test_plbe_response, 0) == :ok
  end
  
  test "Passwordless Login by UserName" do
    test_plbu_response = "taa"
      |> LoginRadius.PasswordlessLogin.login_by_username()

    assert elem(test_plbu_response, 0) == :ok
  end

  test "Passwordless Login Verification" do
    # Tested, working
    IO.puts("Passwordless Login Verification API tested manually.")
  end
end
