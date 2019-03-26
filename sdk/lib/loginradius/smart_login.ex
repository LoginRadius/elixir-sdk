defmodule LoginRadius.SmartLogin do
  @moduledoc """
  Elixir wrapper for the LoginRadius Smart Login API module
  """

  @base_resource "/identity/v2/auth"
  @default_params [{"apikey", Application.fetch_env!(:loginradius, :apikey)}]

  @spec get_request(String.t(), list()) :: LoginRadius.lr_response()
  defp get_request(resource, params) do
    LoginRadius.get_request(
      resource,
      "api",
      [],
      @default_params ++ params
    )
  end

  @doc """
  GET - Smart Login by Email:
  Sends a Smart Login link to a user's email using specified email.
  https://docs.loginradius.com/api/v2/customer-identity-api/smart-login/smart-login-by-email
  """
  @spec login_by_email(String.t(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_email(email, client_guid, smart_login_email_template \\ "", welcome_email_template \\ "", redirect_url \\ "") do
    query_params = [
      {"email", email},
      {"clientguid", client_guid},
      {"smartloginemailtemplate", smart_login_email_template},
      {"welcomeemailtemplate", welcome_email_template},
      {"redirecturl", redirect_url}
    ]

    @base_resource <> "/login/smartlogin"
      |> get_request(query_params)
  end

  @doc """
  GET - Smart Login by UserName:
  Sends a Smart Login link to a user's email using specified username.
  https://docs.loginradius.com/api/v2/customer-identity-api/smart-login/smart-login-by-username
  """
  @spec login_by_username(String.t(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_username(username, client_guid, smart_login_email_template \\ "", welcome_email_template \\ "", redirect_url \\ "") do
    query_params = [
      {"username", username},
      {"clientguid", client_guid},
      {"smartloginemailtemplate", smart_login_email_template},
      {"welcomeemailtemplate", welcome_email_template},
      {"redirecturl", redirect_url}
    ]

    @base_resource <> "/login/smartlogin"
      |> get_request(query_params)
  end

  @doc """
  GET - Smart Login Ping:
  Checks if the Smart Login link has been clicked or not.
  https://docs.loginradius.com/api/v2/customer-identity-api/smart-login/smart-login-ping
  """
  @spec ping(String.t()) :: LoginRadius.lr_response()
  def ping(client_guid) do
    query_params = [
      {"clientguid", client_guid}
    ]

    @base_resource <> "/login/smartlogin/ping"
      |> get_request(query_params)
  end

  @doc """
  GET - Smart Login Verify Token
  Verifies the provided token for Smart Login.
  https://docs.loginradius.com/api/v2/customer-identity-api/smart-login/smart-login-verify-token
  """
  @spec verify_token(String.t(), String.t()) :: LoginRadius.lr_response()
  def verify_token(verification_token, welcome_email_template \\ "") do
    query_params = [
      {"verificationtoken", verification_token},
      {"welcomeemailtemplate", welcome_email_template}
    ]

    @base_resource <> "/email/smartlogin"
      |> get_request(query_params)
  end
end
