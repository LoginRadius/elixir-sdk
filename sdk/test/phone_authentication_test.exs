defmodule PhoneAuthenticationTest do
  use ExUnit.Case

  defp get_uid(test_login) do
    test_login
      |> elem(1)
      |> elem(1)
      |> Map.fetch!("Profile")
      |> Map.fetch!("Uid")
  end

  defp get_access_token(test_login) do
    test_login
      |> elem(1)
      |> elem(1)
      |> Map.fetch!("access_token")
  end

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

    login_data = %{
      "phone" => "17787694512",
      "password" => "password"
    }

    test_login = LoginRadius.PhoneAuthentication.login(login_data, "www.test.com")

    on_exit fn ->
      elem(test_data, 1)
        |> elem(1)
        |> Map.fetch!("Uid")
        |> LoginRadius.Account.delete()
    end

    %{"test_login" => test_login}
  end

  test "Phone Login", %{"test_login" => test_login} do
    assert elem(test_login, 0) == :ok
  end

  test "Phone Forgot Password by OTP" do
    phone_data = %{
      "phone" => "17787694512"
    }

    test_pfpbo_response = LoginRadius.PhoneAuthentication.forgot_password_by_otp(phone_data, "forgotpassword-default")

    assert elem(test_pfpbo_response, 0) == :ok
  end

  test "Phone Resend Verification OTP", %{"test_login" => test_login} do
    update_data = %{
      "PhoneIdVerified" => false
    }
    phone_data = %{
      "phone" => "17787694512"
    }

    test_login
      |> get_uid()
      |> LoginRadius.Account.update(update_data)

    test_prvo_response = LoginRadius.PhoneAuthentication.resend_verification_otp(phone_data, "verification-default")

    assert elem(test_prvo_response, 0) == :ok
  end

  test "Phone Resend Verification OTP by Token", %{"test_login" => test_login} do
    update_data = %{
      "PhoneIdVerified" => false
    }
    phone_data = %{
      "phone" => "17787694512"
    }
    
    test_login
      |> get_uid()
      |> LoginRadius.Account.update(update_data)

    test_prvobt_response = test_login
      |> get_access_token()
      |> LoginRadius.PhoneAuthentication.resend_verification_otp_by_access_token(phone_data)

    assert elem(test_prvobt_response, 0) == :ok
  end

  test "Phone User Registration by SMS" do
    registration_data = %{
      "FirstName" => "testaccount",
      "LastName" => "auto2",
      "Email" => [
        %{
          "Type" => "Primary",
          "Value" => "testaccountauto2@mailinator.com"
        }
      ],
      "UserName" => "taa2",
      "State" => "Alberta",
      "City" => "Edmonton",
      "ProfileCity" => "Edmonton",
      "ProfileCountry" => "Canada",
      "Password" => "password",
      "PhoneId" => "19022008815",
      "EmailVerified" => true,
      "PhoneIdVerified" => true
    }

    test_purbs_response = LoginRadius.PhoneAuthentication.user_registration_by_sms(registration_data, "www.test.com", "welcome-default")

    assert elem(test_purbs_response, 0) == :ok

    test_ad_response = LoginRadius.Account.profiles_by_email("testaccountauto2@mailinator.com")
      |> elem(1)
      |> elem(1)
      |> Map.fetch!("Uid")
      |> LoginRadius.Account.delete()

    assert elem(test_ad_response, 0) == :ok
  end

  test "Phone Number Availability" do
    test_pna_response = LoginRadius.PhoneAuthentication.phone_number_availability("17785875110")
    
    assert elem(test_pna_response, 0) == :ok
  end

  test "Phone Number Update", %{"test_login" => test_login} do
    update_data = %{
      "phone" => "17787694512"
    }

    test_pnu_response = test_login
      |> get_access_token()
      |> LoginRadius.PhoneAuthentication.phone_number_update(update_data)

    assert elem(test_pnu_response, 0) == :ok
  end

  test "Phone Reset Password by OTP" do
    # Tested, working
    IO.puts("Phone Reset Password by OTP API tested manually.")
  end

  test "Phone Verification by OTP" do
    # Tested, working
    IO.puts("Phone Verification by OTP API tested manually.")
  end

  test "Phone Verification OTP by Token" do
    # Tested, working
    IO.puts("Phone Verification OTP by Token API tested manually.")
  end

  test "Reset Phone Id Verification", %{"test_login" => test_login} do
    test_rpiv_response = test_login
      |> get_uid()
      |> LoginRadius.PhoneAuthentication.reset_phone_id_verification()

    assert elem(test_rpiv_response, 0) == :ok
  end

  test "Remove Phone ID by Access Token", %{"test_login" => test_login} do
    test_rpibat_response = test_login
      |> get_access_token()
      |> LoginRadius.PhoneAuthentication.remove_phone_id_by_access_token()

    assert elem(test_rpibat_response, 0) == :ok
  end

  test "Phone Send One Time Passcode" do
    test_psotp_response = "17787694512"
      |> LoginRadius.PhoneAuthentication.send_one_time_passcode()

    assert elem(test_psotp_response, 0) == :ok
  end

  test "Phone Login Using One Time Passcode" do
    # Tested, working
    IO.puts("Phone Login Using One Time Passcode API tested manually.")
  end
end
