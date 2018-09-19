defmodule AuthenticationTest do
  use ExUnit.Case

  defp get_access_token(test_login) do
    elem(test_login, 1)
      |> elem(1)
      |> Map.fetch!("access_token")
  end

  defp get_uid(test_login) do
    elem(test_login, 1)
      |> elem(1)
      |> Map.fetch!("Profile")
      |> Map.fetch!("Uid")
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
        "EmailVerified" => true
      })
    login_data = %{
      "email" => "testaccountauto@mailinator.com",
      "password" => "password"
    }
    sq_data = %{
      "securityquestionanswer" => %{
        "6fc48739c6754040a72033c8d0921969" => "answer"
      }
    }

    test_login = LoginRadius.Authentication.login_by_email(login_data)

    test_login
      |> get_access_token()
      |> LoginRadius.Authentication.update_security_questions_by_access_token(sq_data)

    on_exit fn ->
      elem(test_data, 1)
        |> elem(1)
        |> Map.fetch!("Uid")
        |> LoginRadius.Account.delete()
    end

    %{"test_login" => test_login}
  end

  test "Auth Add Email", %{"test_login" => test_login} do
    update_data = %{
      "email" => "authaddemailtest@mailinator.com",
      "type" => "Secondary"
    }

    test_add_email_response = get_access_token(test_login)
      |> LoginRadius.Authentication.add_email(update_data)
    assert elem(test_add_email_response, 0) == :ok
  end

  test "Auth Forgot Password" do
    update_data = %{
      "email" => "testaccountauto@mailinator.com"
    }

    test_forgot_password_response = LoginRadius.Authentication.forgot_password("localhost:8080", update_data)

    assert elem(test_forgot_password_response, 0) == :ok
  end

  test "Auth User Registration by Email" do
    registration_data = %{
      "Email" => [
        %{
          "Type" => "Primary",
          "Value" => "testaccountauto2@mailinator.com"
        }
      ],
      "Password" => "password"
    }

    test_auth_urbe_response = LoginRadius.Authentication.user_registration_by_email(registration_data)

    assert elem(test_auth_urbe_response, 0) == :ok

    test_ad_response = LoginRadius.Account.profiles_by_email("testaccountauto2@mailinator.com")
      |> elem(1)
      |> elem(1)
      |> Map.fetch!("Uid")
      |> LoginRadius.Account.delete()

    assert elem(test_ad_response, 0) == :ok
  end

  test "Auth Login by Email" do
    login_data = %{
      "email" => "testaccountauto@mailinator.com",
      "password" => "password",
    }

    test_auth_lbe_response = LoginRadius.Authentication.login_by_email(login_data)
    assert elem(test_auth_lbe_response, 0) == :ok
  end

  test "Auth Login by Username" do
    login_data = %{
      "username" => "taa",
      "password" => "password",
    }

    test_auth_lbu_response = LoginRadius.Authentication.login_by_username(login_data)
    assert elem(test_auth_lbu_response, 0) == :ok
  end

  test "Auth Check Email Availability" do
    test_auth_cea_response = "testaccountauto@mailinator.com"
      |> LoginRadius.Authentication.check_email_availability()
    assert elem(test_auth_cea_response, 0) == :ok
    is_exist = test_auth_cea_response
      |> elem(1)
      |> elem(1)
      |> Map.fetch!("IsExist")
    assert is_exist == true
  end

  test "Auth Check Username Availability" do
    test_auth_cua_response = "taa"
      |> LoginRadius.Authentication.check_username_availability()
    assert elem(test_auth_cua_response, 0) == :ok
    is_exist = test_auth_cua_response
      |> elem(1)
      |> elem(1)
      |> Map.fetch!("IsExist")
    assert is_exist == true
  end

  test "Auth Read Profile by Token", %{"test_login" => test_login} do
    test_auth_rpbt_response = get_access_token(test_login)
      |> LoginRadius.Authentication.read_profiles_by_access_token()
    assert elem(test_auth_rpbt_response, 0) == :ok
  end

  test "Auth Read Profile by Token 2" do
    test_auth_rpbt2_response = "84957439865"
      |> LoginRadius.Authentication.read_profiles_by_access_token()
    assert elem(test_auth_rpbt2_response, 0) == :error
  end

  test "Auth Privacy Policy Accept" do
    # No test available
    #test_auth_ppa_response = get_access_token(test_login)
    #  |> LoginRadius.Authentication.privacy_policy_accept()
    #assert elem(test_auth_ppa_response, 0) == :ok
    IO.puts("No test available for Privacy Policy Accept.")
  end

  test "Auth Send Welcome Email", %{"test_login" => test_login} do
    test_auth_swe_response = get_access_token(test_login)
      |> LoginRadius.Authentication.send_welcome_email()
    assert elem(test_auth_swe_response, 0) == :ok
  end

  test "Auth Social Identity", %{"test_login" => test_login} do
    test_auth_si_response = get_access_token(test_login)
      |> LoginRadius.Authentication.social_identity()
    assert elem(test_auth_si_response, 0) == :ok
  end

  test "Auth Validate Access Token", %{"test_login" => test_login} do
    test_auth_vat_response = get_access_token(test_login)
      |> LoginRadius.Authentication.validate_access_token()
    assert elem(test_auth_vat_response, 0) == :ok
  end

  test "Auth Verify Email", %{"test_login" => test_login} do
    update_data = %{
      "EmailVerified" => false
    }
    get_uid(test_login)
      |> LoginRadius.Account.update(update_data, false)

    test_login_email = "testaccountauto@mailinator.com"
    test_auth_ve_response = Map.put(%{}, "email", test_login_email)
      |> LoginRadius.Account.email_verification_token()
      |> elem(1)
      |> elem(1)
      |> Map.fetch!("VerificationToken")
      |> LoginRadius.Authentication.verify_email()
    
    assert elem(test_auth_ve_response, 0) == :ok
  end

  test "Auth Delete Account" do
    # Tested, working
    IO.puts("Auth Delete Account API tested manually.")
  end

  test "Auth Invalidate Access Token", %{"test_login" => test_login} do
    test_auth_iat_response = get_access_token(test_login)
      |> LoginRadius.Authentication.invalidate_access_token()

    assert elem(test_auth_iat_response, 0) == :ok
  end

  test "Auth Security Questions by Access Token", %{"test_login" => test_login} do
    test_auth_sqbat_response = get_access_token(test_login)
      |> LoginRadius.Authentication.security_questions_by_access_token()

    assert elem(test_auth_sqbat_response, 0) == :ok
  end

  test "Auth Security Questions by Email" do
    test_auth_sqbe_response = "testaccountauto@mailinator.com"
      |> LoginRadius.Authentication.security_questions_by_email()

    assert elem(test_auth_sqbe_response, 0) == :ok
  end

  test "Auth Security Questions by Username" do
    test_auth_sqbu_response = "taa"
      |> LoginRadius.Authentication.security_questions_by_username()

    assert elem(test_auth_sqbu_response, 0) == :ok
  end

  test "Auth Security Questions by Phone" do
    test_auth_sqbp_response = "17787694512"
      |> LoginRadius.Authentication.security_questions_by_phone()

    assert elem(test_auth_sqbp_response, 0) == :ok
  end

  test "Auth Verify Email by OTP" do
    # Tested, working
    IO.puts("Auth Verify Email by OTP Tested Manually.")
  end

  test "Auth Change Password", %{"test_login" => test_login} do
    update_data = %{
      "oldpassword" => "password",
      "newpassword" => "passwords"
    }

    test_auth_cp_response = get_access_token(test_login)
      |> LoginRadius.Authentication.change_password(update_data)

    assert elem(test_auth_cp_response, 0) == :ok
  end

  test "Auth Link/Unlink Social Identities", %{"test_login" => test_login} do
    if LoginRadiusTest.social_login_request_token() == "" do
      IO.puts("Need to specify a social login request token to test linking/unlinking social identities.")
    else
      IO.puts("If this test fails (Link/Unlink Social Identities), check validity of social provider request token in loginradius_test.exs.")
      update_data = %{
        "candidatetoken" => LoginRadiusTest.social_login_request_token()
      }

      test_auth_lsi_response = test_login
        |> get_access_token
        |> LoginRadius.Authentication.link_social_identities(update_data)

      assert elem(test_auth_lsi_response, 0) == :ok

      test_account_info = LoginRadius.Account.profiles_by_email("testaccountauto@mailinator.com")
        |> elem(1)
        |> elem(1)

      account_provider = test_account_info
        |> Map.fetch!("Identities")
        |> List.first()
        |> Map.fetch!("Provider")

      account_provider_id = test_account_info
        |> Map.fetch!("Identities")
        |> List.first()
        |> Map.fetch!("ID")

      unlink_data = %{
        "provider" => account_provider,
        "providerid" => account_provider_id
      }

      test_auth_usi_response = test_login
        |> get_access_token
        |> LoginRadius.Authentication.unlink_social_identities(unlink_data)
      
      assert elem(test_auth_usi_response, 0) == :ok
    end
  end

  test "Auth Resend Email Verification", %{"test_login" => test_login} do
    update_data = %{
      "EmailVerified" => false
    }
    get_uid(test_login)
      |> LoginRadius.Account.update(update_data, false)
    
    update_data2 = %{
      "email" => "testaccountauto@mailinator.com"
    }

    test_auth_rev_response = LoginRadius.Authentication.resend_email_verification(update_data2)

    assert elem(test_auth_rev_response, 0) == :ok
  end

  test "Auth Reset Password by Reset Token" do
    # Tested, working
    IO.puts("Auth Reset Password by Reset Token tested manually.")
  end

  test "Auth Reset Password by OTP" do
    # Tested, working
    IO.puts("Auth Reset Password by OTP tested manually.")
  end
  
  test "Auth Reset Password by Security Answer and Email" do
    update_data = %{
      "securityanswer" => %{
        "6fc48739c6754040a72033c8d0921969" => "answer"
      },
      "email" => "testaccountauto@mailinator.com",
      "password" => "password",
      "resetpasswordemailtemplate" => ""
    }

    test_auth_rpbsaae_response = LoginRadius.Authentication.reset_password_by_security_answer_and_email(update_data)

    assert elem(test_auth_rpbsaae_response, 0) == :ok
  end

  test "Auth Reset Password by Security Answer and Phone" do
    update_data = %{
      "securityanswer" => %{
        "6fc48739c6754040a72033c8d0921969" => "answer"
      },
      "phone" => "17787694512",
      "password" => "password",
      "resetpasswordemailtemplate" => ""
    }

    test_auth_rpbsaap_response = LoginRadius.Authentication.reset_password_by_security_answer_and_phone(update_data)

    assert elem(test_auth_rpbsaap_response, 0) == :ok
  end

  test "Auth Reset Password by Security Answer and Username" do
    update_data = %{
      "securityanswer" => %{
        "6fc48739c6754040a72033c8d0921969" => "answer"
      },
      "username" => "taa",
      "password" => "password",
      "resetpasswordemailtemplate" => ""
    }

    test_auth_rpbsaau_response = LoginRadius.Authentication.reset_password_by_security_answer_and_username(update_data)

    assert elem(test_auth_rpbsaau_response, 0) == :ok
  end

  test "Auth Set or Change Username", %{"test_login" => test_login} do
    update_data = %{
      "username" => "testaccountauto"
    }

    test_auth_socu_response = get_access_token(test_login)
      |> LoginRadius.Authentication.set_or_change_username(update_data)

    assert elem(test_auth_socu_response, 0) == :ok
  end

  test "Auth Update Profile by Access Token", %{"test_login" => test_login} do
    update_data = %{
      "Company" => "LoginRadius"
    }

    test_auth_upbat_response = get_access_token(test_login)
      |> LoginRadius.Authentication.update_profile_by_access_token(update_data)

    assert elem(test_auth_upbat_response, 0) == :ok
    response_company = elem(test_auth_upbat_response, 1)
      |> elem(1)
      |> Map.fetch!("Data")
      |> Map.fetch!("Company")
    assert response_company == "LoginRadius"
  end

  test "Auth Update Security Question by Access Token", %{"test_login" => test_login} do
    update_data = %{
      "securityquestionanswer" => %{
        "6fc48739c6754040a72033c8d0921969" => "newanswer"
      }
    }

    test_auth_usqbat_response = get_access_token(test_login)
      |> LoginRadius.Authentication.update_security_questions_by_access_token(update_data)

    assert elem(test_auth_usqbat_response, 0) == :ok
  end

  test "Auth Delete Account with Email Confirmation", %{"test_login" => test_login} do
    test_auth_dawec_response = get_access_token(test_login)
      |> LoginRadius.Authentication.delete_account_with_email_confirmation()

    assert elem(test_auth_dawec_response, 0) == :ok
  end

  test "Auth Remove Email", %{"test_login" => test_login} do
    update_data = %{
      "Email" => [
        %{
          "Type" => "Secondary",
          "Value" => "emailtodelete@mailinator.com"
        }
      ]
    }
    delete_data = %{
      "email" => "emailtodelete@mailinator.com"
    }

    get_uid(test_login)
      |> LoginRadius.Account.update(update_data)

    test_remove_email_response = get_access_token(test_login)
      |> LoginRadius.Authentication.remove_email(delete_data)
    assert elem(test_remove_email_response, 0) == :ok
  end
end
