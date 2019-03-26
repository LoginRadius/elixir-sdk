defmodule LoginRadius.TokenManagement do
  @moduledoc """
  Elixir wrapper for the LoginRadius Token Management API module.
  API documentation is found under the 'Social Share and Access Permissions' section.
  """

  @base_resource "/api/v2"
  @apikey Application.fetch_env!(:loginradius, :apikey)
  @apisecret Application.fetch_env!(:loginradius, :apisecret)

  @spec get_request(String.t(), list()) :: LoginRadius.lr_response()
  defp get_request(resource, params) do
    LoginRadius.get_request(
      resource,
      "api",
      [],
      params
    ) 
  end

  @doc """
  GET - Access Token via Facebook Token:
  Retrieves a LoginRadius access token by sending Facebook's access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/native-social-login-api/access-token-via-facebook-token
  """
  @spec access_token_via_facebook_token(String.t()) :: LoginRadius.lr_response()
  def access_token_via_facebook_token(fb_access_token) do
    query_params = [
      {"key", @apikey},
      {"fb_access_token", fb_access_token}
    ]

    @base_resource <> "/access_token/facebook"
      |> get_request(query_params)
  end

  @doc """
  GET - Access Token via Twitter Token:
  Retrieves a LoginRadius access token by sending Twitter's access token and token secret.
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/native-social-login-api/access-token-via-twitter-token
  """
  @spec access_token_via_twitter_token(String.t(), String.t()) :: LoginRadius.lr_response()
  def access_token_via_twitter_token(tw_access_token, tw_token_secret) do
    query_params = [
      {"key", @apikey},
      {"tw_access_token", tw_access_token},
      {"tw_token_secret", tw_token_secret}
    ]

    @base_resource <> "/access_token/twitter"
      |> get_request(query_params)
  end

  @doc """
  GET - Access Token via Vkontakte Token:
  Retrieves a LoginRadius access token by sending Vkontakte's access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/native-social-login-api/access-token-via-vkontakte-token
  """
  @spec access_token_via_vkontakte_token(String.t()) :: LoginRadius.lr_response()
  def access_token_via_vkontakte_token(vk_access_token) do
    query_params = [
      {"key", @apikey},
      {"vk_access_token", vk_access_token}
    ]

    @base_resource <> "/access_token/vkontakte"
      |> get_request(query_params)
  end

  @doc """
  GET - Refresh User Profile:
  Retrieves the latest updated social profile data after authentication.
  https://docs.loginradius.com/api/v2/customer-identity-api/refresh-token/refresh-user-profile
  """
  @spec refresh_user_profile(String.t()) :: LoginRadius.lr_response()
  def refresh_user_profile(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/userprofile/refresh"
      |> get_request(query_params)
  end

  @doc """
  GET - Refresh Access Token:
  Refreshes the LoginRadius access token after authentication. Also refreshes the
  provider access token if available.
  https://docs.loginradius.com/api/v2/advanced-social-api/refresh-token
  """
  @spec refresh_access_token(String.t()) :: LoginRadius.lr_response()
  def refresh_access_token(access_token) do
    query_params = [
      {"access_token", access_token},
      {"secret", @apisecret}
    ]

    @base_resource <> "/access_token/refresh"
      |> get_request(query_params)
  end

  @doc """
  GET - Get Active Session Details:
  Retrieves all active sessions by an access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/get-active-session-details
  """
  @spec get_active_session_details(String.t()) :: LoginRadius.lr_response()
  def get_active_session_details(access_token) do
    query_params = [
      {"key", @apikey},
      {"secret", @apisecret},
      {"token", access_token}
    ]

    @base_resource <> "/access_token/activesession"
      |> get_request(query_params)
  end
end
