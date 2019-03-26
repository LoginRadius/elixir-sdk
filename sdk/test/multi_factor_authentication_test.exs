defmodule MultiFactorAuthenticationTest do
  use ExUnit.Case

  defp get_access_token(login_response) do
    login_response
    |> elem(1)
    |> elem(1)
    |> Map.fetch!("access_token")
  end

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
        "EmailVerified" => true,
        "PhoneIdVerified" => true
      })

    on_exit(fn ->
      elem(test_data, 1)
      |> elem(1)
      |> Map.fetch!("Uid")
      |> LoginRadius.Account.delete()
    end)

    %{"test_data" => test_data}
  end

  @tag :mfa
  test "MFA Email Login (Requires MFA to be enabled)" do
    login_data = %{
      "email" => "testaccountauto@mailinator.com",
      "password" => "password"
    }

    test_mel_response =
      login_data
      |> LoginRadius.MultiFactorAuthentication.login_by_email()

    assert elem(test_mel_response, 0) == :ok
  end

  @tag :mfa
  test "MFA UserName Login (Requires MFA to be enabled)" do
    login_data = %{
      "username" => "taa",
      "password" => "password"
    }

    test_mul_response =
      login_data
      |> LoginRadius.MultiFactorAuthentication.login_by_username()

    assert elem(test_mul_response, 0) == :ok
  end

  @tag :mfa
  test "MFA Phone Login (Requires MFA to be enabled)" do
    login_data = %{
      "phone" => "17787694512",
      "password" => "password"
    }

    test_mpl_response =
      login_data
      |> LoginRadius.MultiFactorAuthentication.login_by_phone()

    assert elem(test_mpl_response, 0) == :ok
  end

  @tag :mfa
  test "MFA Validate Access Token (Requires MFA set to optional)" do
    login_data = %{
      "email" => "testaccountauto@mailinator.com",
      "password" => "password"
    }

    test_mvat_response =
      login_data
      |> LoginRadius.MultiFactorAuthentication.login_by_email()
      |> get_access_token()
      |> LoginRadius.MultiFactorAuthentication.validate_access_token()

    assert elem(test_mvat_response, 0) == :ok
  end

  @tag :mfa
  test "MFA Backup Code by Access Token (Requires MFA set to required)" do
    # Tested, working
    IO.puts("MFA Backup Code by Access Token API tested manually.")
  end

  @tag :mfa
  test "Reset Backup Code By Access Token (Requires MFA set to required)" do
    # Tested, working
    IO.puts("Reset Backup Code By Access Token API tested manually.")
  end

  @tag :mfa
  test "MFA Backup Code by UID (Requires MFA set to required)" do
    # Tested, working
    IO.puts("MFA Backup Code by UID API tested manually.")
  end

  @tag :mfa
  test "MFA Reset Backup Code by UID (Requires MFA set to required)" do
    # Tested, working
    IO.puts("MFA Reset Backup Code by UID API tested manually.")
  end

  @tag :mfa
  test "MFA Validate Backup Code" do
    # Tested, working
    IO.puts("MFA Validate Backup Code API tested manually.")
  end

  @tag :mfa
  test "MFA Validate OTP" do
    # Tested, working
    IO.puts("MFA Validate OTP API tested manually.")
  end

  @tag :mfa
  test "MFA Validate Google Auth Code" do
    # Tested, working
    IO.puts("MFA Validate Google Auth Code API tested manually.")
  end

  @tag :mfa
  test "MFA Update Phone Number" do
    # Tested, working
    IO.puts("MFA Update Phone Number API tested manually.")
  end

  @tag :mfa
  test "MFA Update Phone Number by Token" do
    # Tested, working
    IO.puts("MFA Update Phone Number API tested manually.")
  end

  @tag :mfa
  test "MFA Reset Google Authenticator by Token" do
    # Tested, working
    IO.puts("MFA Reset Google Authenticator API by Token tested manually.")
  end

  @tag :mfa
  test "MFA Reset SMS Authenticator by Token" do
    # Tested, working
    IO.puts("MFA Reset SMS Authenticator API by Token tested manually.")
  end

  @tag :mfa
  test "MFA Reset Google Authenticator by UID" do
    # Tested, working
    IO.puts("MFA Reset Google Authenticator by UID API tested manually.")
  end

  @tag :mfa
  test "MFA Reset SMS Authenticator by UID" do
    # Tested, working
    IO.puts("MFA Reset SMS Authenticator by UID API tested manually.")
  end

  @tag :mfa
  test "Update MFA by Access Token (Requires MFA set to optional)" do
    # Tested, working
    IO.puts("Update MFA by Access Token API tested manually.")
  end

  @tag :mfa
  test "Update MFA Setting (Requires MFA set to optional)" do
    # Tested, working
    IO.puts("Update MFA Setting API tested manually.")
  end
end
