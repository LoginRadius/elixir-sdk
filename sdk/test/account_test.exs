defmodule AccountTest do
  use ExUnit.Case

  defp get_uid(data) do
    elem(data, 1)
    |> elem(1)
    |> Map.fetch!("Uid")
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
        "PhoneId" => "17787694512"
      })

    on_exit(fn ->
      get_uid(test_data)
      |> LoginRadius.Account.delete()
    end)

    %{"test_data" => test_data}
  end

  test "Account Create", %{"test_data" => test_data} do
    assert elem(test_data, 0) == :ok
  end

  test "Account Email Verification Token" do
    test_data_evt_response =
      Map.put(%{}, "email", "testaccountauto@mailinator.com")
      |> LoginRadius.Account.email_verification_token()

    assert elem(test_data_evt_response, 0) == :ok
  end

  test "Account Forgot Password Token" do
    test_data_fpt_response =
      Map.put(%{}, "email", "testaccountauto@mailinator.com")
      |> LoginRadius.Account.forgot_password_token()

    assert elem(test_data_fpt_response, 0) == :ok
  end

  test "Account Identities by Email" do
    test_data_ibe_response =
      "testaccountauto@mailinator.com"
      |> LoginRadius.Account.identities_by_email()

    assert elem(test_data_ibe_response, 0) == :ok
  end

  test "Account Impersonation Access Token", %{"test_data" => test_data} do
    test_data_iat_response =
      get_uid(test_data)
      |> LoginRadius.Account.user_impersonation()

    assert elem(test_data_iat_response, 0) == :ok
  end

  test "Account Retrieve Hashed Password", %{"test_data" => test_data} do
    test_data_rhp_response =
      get_uid(test_data)
      |> LoginRadius.Account.password()

    assert elem(test_data_rhp_response, 0) == :ok
  end

  test "Account Retrieve Profile by Email" do
    test_data_rpbe_response =
      "testaccountauto@mailinator.com"
      |> LoginRadius.Account.profiles_by_email()

    assert elem(test_data_rpbe_response, 0) == :ok
  end

  test "Account Retrieve Profile by Username" do
    test_data_rpbusername_response =
      "taa"
      |> LoginRadius.Account.profiles_by_username()

    assert elem(test_data_rpbusername_response, 0) == :ok
  end

  test "Account Retrieve Profile by PhoneID" do
    test_data_rpbp_response =
      "17787694512"
      |> LoginRadius.Account.profiles_by_phoneid()

    assert elem(test_data_rpbp_response, 0) == :ok
  end

  test "Account Retrieve Profile by UID", %{"test_data" => test_data} do
    test_data_rpbuid_response =
      get_uid(test_data)
      |> LoginRadius.Account.profiles_by_uid()

    assert elem(test_data_rpbuid_response, 0) == :ok
  end

  test "Account Set Password", %{"test_data" => test_data} do
    test_new_password = Map.put(%{}, "password", "passwords")

    test_data_set_password_response =
      get_uid(test_data)
      |> LoginRadius.Account.set_password(test_new_password)

    assert elem(test_data_set_password_response, 0) == :ok
  end

  test "Account Update", %{"test_data" => test_data} do
    update_data = %{
      "Gender" => "M"
    }

    test_data_update_response =
      get_uid(test_data)
      |> LoginRadius.Account.update(update_data, false)

    assert_value =
      elem(test_data_update_response, 1)
      |> elem(1)
      |> Map.fetch!("Gender")

    assert assert_value == "M"
  end

  test "Account Update Security Question Configuration", %{"test_data" => test_data} do
    update_data = %{
      "securityquestionanswer" => %{
        "6fc48739c6754040a72033c8d0921969" => "newanswer"
      }
    }

    test_data_usqc_response =
      get_uid(test_data)
      |> LoginRadius.Account.update_security_question_configuration(update_data)

    assert elem(test_data_usqc_response, 0) == :ok
  end

  test "Account Invalidate Verification Email", %{"test_data" => test_data} do
    update_data = %{
      "EmailVerified" => true
    }

    get_uid(test_data)
    |> LoginRadius.Account.update(update_data, false)

    test_account_ive_response =
      get_uid(test_data)
      |> LoginRadius.Account.invalidate_verification_status()

    assert elem(test_account_ive_response, 0) == :ok
  end

  test "Account Email Delete", %{"test_data" => test_data} do
    update_data = %{
      "Email" => [
        %{
          "Type" => "Secondary",
          "Value" => "emailtodelete@mailinator.com"
        }
      ]
    }

    test_data_update_response =
      get_uid(test_data)
      |> LoginRadius.Account.update(update_data, false)

    assert_value1 =
      elem(test_data_update_response, 1)
      |> elem(1)
      |> Map.fetch!("Email")
      |> List.last()
      |> Map.fetch!("Value")

    assert assert_value1 == "emailtodelete@mailinator.com"

    delete_data = %{
      "email" => "emailtodelete@mailinator.com"
    }

    test_data_delete_response =
      get_uid(test_data)
      |> LoginRadius.Account.email_delete(delete_data)

    assert_value2 =
      elem(test_data_delete_response, 1)
      |> elem(1)
      |> Map.fetch!("Email")
      |> List.last()
      |> Map.fetch!("Value")

    assert assert_value2 == "testaccountauto@mailinator.com"
  end

  test "Test Account Delete", %{"test_data" => _test_data} do
    IO.puts(
      "If tests are being set up and cleaned properly, this API (Account Delete) is working properly."
    )
  end
end
