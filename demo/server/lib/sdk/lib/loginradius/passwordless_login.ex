defmodule LoginRadius.PasswordlessLogin do
  @moduledoc """
  Elixir wrapper for the LoginRadius Passwordless Login API module
  """

  @base_resource "/identity/v2/auth/login/passwordlesslogin"
  @default_params [
    {"apikey", Application.fetch_env!(:loginradius_elixir_sdk, :apikey)}
  ]

  @spec get_request(String.t(), list(), list()) :: LoginRadius.response()
  defp get_request(resource, headers, params) do
    LoginRadius.get_request(
      resource,
      headers,
      @default_params ++ params
    )
  end

  @doc """
  GET - Passwordless Login by Email:
  Sends a Passwordless Login verification link to provided email.
  https://docs.loginradius.com/api/v2/user-registration/passwordless-login-by-email
  """
  @spec login_by_email(String.t(), String.t(), String.t()) :: LoginRadius.response()
  def login_by_email(email, passwordless_login_template \\ "", verification_url \\ "") do
    query_params = [
      {"email", email},
      {"passwordlesslogintemplate", passwordless_login_template},
      {"verificationurl", verification_url}
    ]

    @base_resource <> "/email"
      |> get_request([], query_params)
  end

  @doc """
  GET - Passwordless Login by UserName:
  Sends a Passwordless Login verification link to provided username.
  https://docs.loginradius.com/api/v2/user-registration/passwordless-login-by-username
  """
  @spec login_by_username(String.t(), String.t(), String.t()) :: LoginRadius.response()
  def login_by_username(username, passwordless_login_template \\ "", verification_url \\ "") do
    query_params = [
      {"username", username},
      {"passwordlesslogintemplate", passwordless_login_template},
      {"verificationurl", verification_url}
    ]

    @base_resource <> "/email"
      |> get_request([], query_params)
  end

  @doc """
  GET - Passwordless Login Verification:
  Verifies a Passwordless Login verification link.
  https://docs.loginradius.com/api/v2/user-registration/passwordless-login-verification
  """
  @spec login_verification(String.t(), String.t()) :: LoginRadius.response()
  def login_verification(verification_token, welcome_email_template \\ "") do
    query_params = [
      {"verificationtoken", verification_token},
      {"welcomeemailtemplate", welcome_email_template}
    ]

    @base_resource <> "/email/verify"
      |> get_request([], query_params)
  end
end
