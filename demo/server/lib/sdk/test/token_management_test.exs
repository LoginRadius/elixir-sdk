defmodule TokenManagementTest do
  use ExUnit.Case

  defp get_access_token(test_login) do
    elem(test_login, 1)
      |> elem(1)
      |> Map.fetch!("access_token")
  end

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
    login_data = %{
      "email" => "testaccountauto@mailinator.com",
      "password" => "password"
    }

    test_login = LoginRadius.Authentication.login_by_email(login_data)

    on_exit fn ->
      elem(test_data, 1)
        |> elem(1)
        |> Map.fetch!("Uid")
        |> LoginRadius.Account.delete()
    end

    %{"test_login" => test_login}
  end

  test "Access Token via Facebook Token" do
    if LoginRadiusTest.facebook_access_token() == "" do
      IO.puts("Need to specify a Facebook access token to test Access Token via Facebook Token API.")
    else
      test_atvft_response = LoginRadiusTest.facebook_access_token()
        |> LoginRadius.TokenManagement.access_token_via_facebook_token()

      assert elem(test_atvft_response, 0) == :ok
    end
  end

  test "Access Token via Twitter Token" do
    if LoginRadiusTest.twitter_access_token() == "" && LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts("Need to specify a Twitter access token and token secret to test Access Token via Twitter Token API.")
    else 
      test_atvtt_response = LoginRadiusTest.twitter_access_token()
        |> LoginRadius.TokenManagement.access_token_via_twitter_token(LoginRadiusTest.twitter_token_secret())
      
      assert elem(test_atvtt_response, 0) == :ok
    end
  end

  test "Access Token via Vkontakte Token" do
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Access Token via Vkontakte Token API.")
    else 
      test_atvvt_response = LoginRadiusTest.vkontakte_access_token()
        |> LoginRadius.TokenManagement.access_token_via_vkontakte_token()
      
      assert elem(test_atvvt_response, 0) == :ok
    end
  end

  test "Refresh User Profile", %{"test_login" => test_login} do
    test_rup_response = test_login
      |> get_access_token()
      |> LoginRadius.TokenManagement.refresh_user_profile()
    
    assert elem(test_rup_response, 0) == :ok
  end

  test "Refresh Token", %{"test_login" => test_login} do
    test_rt_response = test_login
      |> get_access_token()
      |> LoginRadius.TokenManagement.refresh_access_token()

    assert elem(test_rt_response, 0) == :ok
  end

  test "Get Active Session Details", %{"test_login" => test_login} do

    test_gasd_response = test_login
      |> get_access_token()
      |> LoginRadius.TokenManagement.get_active_session_details()

    assert elem(test_gasd_response, 0) == :ok
  end
end
