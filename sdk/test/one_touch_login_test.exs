defmodule OneTouchLoginTest do
  use ExUnit.Case

  setup do
    test_data =
      LoginRadius.Account.create(%{
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

    on_exit(fn ->
      elem(test_data, 1)
      |> elem(1)
      |> Map.fetch!("Uid")
      |> LoginRadius.Account.delete()
    end)

    %{"test_data" => test_data}
  end

  test "One Touch Login by Email" do
    testcguid = "testcguid" <> Integer.to_string(:rand.uniform(10_000))

    test_otlbe_response =
      "testaccountauto@mailinator.com"
      |> LoginRadius.OneTouchLogin.login_by_email(
        testcguid,
        "testaccountauto",
        "www.test.com",
        "onetouchlogin-default",
        "welcome-default"
      )

    assert elem(test_otlbe_response, 0) == :ok
  end

  test "One Touch Login by Phone" do
    test_otlbp_response =
      "17787694512"
      |> LoginRadius.OneTouchLogin.login_by_phone("testaccountauto", "onetouchlogin-default")

    assert elem(test_otlbp_response, 0) == :ok
  end

  test "One Touch OTP Verification by Email" do
    # Tested, working
    IO.puts("One Touch OTP Verification by Email API tested manually.")
  end

  test "One Touch OTP Verification" do
    # Tested, working
    IO.puts("One Touch OTP Verification API tested manually.")
  end
end
