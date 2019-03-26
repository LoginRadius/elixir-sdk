defmodule LoginRadius.OneTouchLogin do
  @moduledoc """
  Elixir wrapper for the LoginRadius One Touch Login API module
  """

  @base_resource "/identity/v2/auth"
  @default_headers [
    {"Content-Type", "application/json"}
  ]
  @default_params [
    {"apikey", Application.fetch_env!(:loginradius, :apikey)}
  ]

  @spec get_request(String.t(), list()) :: LoginRadius.lr_response()
  defp get_request(resource, params) do
    LoginRadius.get_request(
      resource,
      "api",
      [],
      @default_params ++ params
    )
  end
  
  @spec put_request(String.t(), map(), list()) :: LoginRadius.lr_response()
  defp put_request(resource, data, params) do
    LoginRadius.put_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params ++ params
    )
  end

  @doc """
  GET - One Touch Login by Email:
  Sends a link to a specified email for frictionless login.
  https://docs.loginradius.com/api/v2/one-touch/one-touch-login-by-email
  """
  @spec login_by_email(String.t(), String.t(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_email(email, client_guid, name \\ "", redirect_url \\ "", one_touch_login_email_template \\ "", welcome_email_template \\ "") do
    query_params = [
      {"clientguid", client_guid},
      {"email", email},
      {"name", name},
      {"redirecturl", redirect_url},
      {"onetouchloginemailtemplate", one_touch_login_email_template},
      {"welcomeemailtemplate", welcome_email_template}
    ]

    @base_resource <> "/onetouchlogin/email"
      |> get_request(query_params)
  end

  @doc """
  GET - One Touch Login by Phone:
  Sends a One Time Password to a given phone number for a frictionless login.
  https://docs.loginradius.com/api/v2/one-touch/one-touch-login-by-phone
  """
  @spec login_by_phone(String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_phone(phone_id, name \\ "", sms_template \\ "") do
    query_params = [
      {"phone", phone_id},
      {"name", name},
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/onetouchlogin/phone"
      |> get_request(query_params)
  end

  @doc """
  GET - One Touch Email Verification:
  Verifies the provided token for One Touch Login by email.
  https://docs.loginradius.com/api/v2/customer-identity-api/one-touch-login/one-touch-email-verification
  """
  @spec verify_otp_by_email(String.t(), String.t()) :: LoginRadius.lr_response()
  def verify_otp_by_email(verification_token, welcome_email_template \\ "") do
    query_params = [
      {"verificationtoken", verification_token},
      {"welcomeemailtemplate", welcome_email_template}
    ]

    @base_resource <> "/email/smartlogin"
      |> get_request(query_params)
  end

  @doc """
  PUT - One Touch OTP Verification:
  Verifies the One Time Passcode for One Touch Login.
  https://docs.loginradius.com/api/v2/customer-identity-api/one-touch-login/one-touch-otp-verification
  """
  @spec verify_otp(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def verify_otp(otp, data, sms_template \\ "") do
    query_params = [
      {"otp", otp},
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/onetouchlogin/phone/verify"
      |> put_request(data, query_params)
  end
end
