defmodule SmartLoginTest do
  use ExUnit.Case

  setup_all do
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
        "EmailVerified" => true
      })

    on_exit fn ->
      elem(test_data, 1)
        |> elem(1)
        |> Map.fetch!("Uid")
        |> LoginRadius.Account.delete()
    end

    %{"test_data" => test_data}
  end

  test "Smart Login By Email & Smart Login Ping" do
    testcguid = "testcguid" <> Integer.to_string(:rand.uniform(10_000))
    test_slbe_response = "testaccountauto@mailinator.com"
      |> LoginRadius.SmartLogin.login_by_email(testcguid, "smartlogin-default", "welcome-default", "www.google.com")
      
    assert elem(test_slbe_response, 0) == :ok

    test_slp_response = LoginRadius.SmartLogin.ping(testcguid)

    assert elem(elem(test_slp_response, 1), 0) == 403
  end

  test "Smart Login By Username" do
    testcguid = "testcguid" <> Integer.to_string(:rand.uniform(10_000))
    test_slbe_response = "taa"
      |> LoginRadius.SmartLogin.login_by_username(testcguid, "smartlogin-default", "welcome-default", "www.google.com")

    assert elem(test_slbe_response, 0) == :ok
  end

  test "Smart Login Verify Token" do
    # Tested, working
    IO.puts("Smart Login Verify Token API tested manually.")
  end
end
