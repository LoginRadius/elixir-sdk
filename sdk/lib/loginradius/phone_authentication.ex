defmodule LoginRadius.PhoneAuthentication do
  @moduledoc """
  Elixir wrapper for the LoginRadius Phone Authentication API module
  """
  
  @apisecret Application.fetch_env!(:loginradius, :apisecret)

  @base_resource "/identity/v2"
  @default_headers [
    {"Content-Type", "application/json"}
  ]
  @default_params [
    {"apikey", Application.fetch_env!(:loginradius, :apikey)}
  ]

  @spec post_request(String.t(), map(), list(), list()) :: LoginRadius.lr_response()
  defp post_request(resource, data, headers, params) do
    LoginRadius.post_request(
      resource,
      "api",
      data,
      @default_headers ++ headers,
      @default_params ++ params
    )
  end

  @spec get_request(String.t(), list(), list()) :: LoginRadius.lr_response()
  defp get_request(resource, headers, params) do
    LoginRadius.get_request(
      resource,
      "api",
      headers,
      @default_params ++ params
    )
  end

  @spec put_request(String.t(), map(), list(), list()) :: LoginRadius.lr_response()
  defp put_request(resource, data, headers \\ [], params \\ []) do
    LoginRadius.put_request(
      resource,
      "api",
      data,
      @default_headers ++ headers,
      @default_params ++ params
    )
  end

  @spec delete_request(String.t(), map(), list(), list()) :: LoginRadius.lr_response()
  defp delete_request(resource, data, headers, params \\ []) do
    LoginRadius.delete_request(
      resource,
      "api",
      data,
      @default_headers ++ headers,
      @default_params ++ params
    )
  end

  @doc """
  POST - Phone Login:
  Retrieves a copy of user data based on Phone ID.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-login
  """
  @spec login(map(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login(data, login_url \\ "", sms_template \\ "", g_recaptcha_response \\ "") do
    query_params = [
      {"loginurl", login_url},
      {"smstemplate", sms_template},
      {"g-recaptcha-response", g_recaptcha_response}
    ]
    
    @base_resource <> "/auth/login"
      |> post_request(data, [], query_params)
  end

  @doc """
  POST - Phone Forgot Password by OTP:
  Sends OTP to reset the account password.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-forgot-password-by-otp
  """
  @spec forgot_password_by_otp(map(), String.t()) :: LoginRadius.lr_response()
  def forgot_password_by_otp(data, sms_template \\ "") do
    query_params = [
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/auth/password/otp"
      |> post_request(data, [], query_params)
  end

  @doc """
  POST - Phone Resend Verification OTP:
  Resends a verification OTP to verify a user's phone number. User will receive a verification
  code that they will need to input.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-resend-otp
  """
  @spec resend_verification_otp(map(), String.t()) :: LoginRadius.lr_response()
  def resend_verification_otp(data, sms_template \\ "") do
    query_params = [
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/auth/phone/otp"
      |> post_request(data, [], query_params)
  end

  @doc """
  POST - Phone Resend Verification OTP by Access Token:
  Resends a verification OTP to verify a user's phone number in cases where an active token
  already exists.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-resend-otp-by-token
  """
  @spec resend_verification_otp_by_access_token(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def resend_verification_otp_by_access_token(access_token, data, sms_template \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/auth/phone/otp"
      |> post_request(data, headers, query_params)
  end

  @doc """
  POST - Phone User Registration by SMS:
  Registers a new user into Cloud Storage and triggers the phone verification process.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-user-registration-by-sms
  """
  @spec user_registration_by_sms(map(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def user_registration_by_sms(data, verification_url \\ "", sms_template \\ "", options \\ "") do
    headers = [
      {"X-LoginRadius-Sott", LoginRadius.Infrastructure.local_generate_sott()}
    ]
    query_params = [
      {"verificationurl", verification_url},
      {"smstemplate", sms_template},
      {"options", options}
    ]

    @base_resource <> "/auth/register"
      |> post_request(data, headers, query_params)
  end

  @doc """
  GET - Phone Number Availability:
  Checks if the specified phone number already exists on your site.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-number-availability
  """
  @spec phone_number_availability(String.t()) :: LoginRadius.lr_response()
  def phone_number_availability(phone_id) do
    query_params = [
      {"phone", phone_id}
    ]

    @base_resource <> "/auth/phone"
      |> get_request([], query_params)
  end

  @doc """
  GET - Phone Send One Time Passcode:
  Sends a One Time Passcode by verified phone ID.
  This API is listed under the Passwordless Login section.
  https://docs.loginradius.com/api/v2/customer-identity-api/passwordless-login/phone-send-otp
  """
  @spec send_one_time_passcode(String.t(), String.t()) :: LoginRadius.lr_response()
  def send_one_time_passcode(phone_id, sms_template \\ "") do
    query_params = [
      {"phone", phone_id},
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/auth/login/passwordlesslogin/otp"
      |> get_request([], query_params)
  end
  
  @doc """
  PUT - Phone Login Using One Time Passcode:
  Verifies a login by One Time Passcode.
  This API is listed under the Passwordless Login section.
  https://docs.loginradius.com/api/v2/customer-identity-api/passwordless-login/phone-login-using-otp
  """
  @spec login_using_one_time_passcode(map()) :: LoginRadius.lr_response()
  def login_using_one_time_passcode(data) do
    @base_resource <> "/auth/login/passwordlesslogin/otp/verify"
      |> put_request(data)
  end

  @doc """
  PUT - Phone Number Update:
  Updates a user's login phone number.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-number-update
  """
  @spec phone_number_update(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def phone_number_update(access_token, data, sms_template \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/auth/phone"
      |> put_request(data, headers, query_params)
  end

  @doc """
  PUT - Phone Reset Password by OTP:
  Resets a user's password using OTP.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-reset-password-by-otp
  """
  @spec reset_password_by_otp(map()) :: LoginRadius.lr_response()
  def reset_password_by_otp(data) do
    @base_resource <> "/auth/password/otp"
      |> put_request(data)
  end

  @doc """
  PUT - Phone Verification by OTP:
  Validates the verification code sent to verify a user's phone number.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-verify-otp
  """
  @spec verify_otp(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def verify_otp(otp, data, sms_template \\ "") do
    query_params = [
      {"otp", otp},
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/auth/phone/otp"
      |> put_request(data, [], query_params)
  end

  @doc """
  PUT - Phone Verification OTP by Access Token:
  Consumes the verification code sent to verify a user's phone number. For use in front-end where
  user has already logged in by passing user's access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/phone-verify-otp-by-token
  """
  @spec verify_otp_by_access_token(String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def verify_otp_by_access_token(access_token, otp, sms_template \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"otp", otp},
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/auth/phone/otp"
      |> put_request(%{}, headers, query_params)
  end

  @doc """
  PUT - Reset Phone ID Verification:
  Resets phone number verification of a user's account.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/reset-phone-id-verification
  """
  @spec reset_phone_id_verification(String.t()) :: LoginRadius.lr_response()
  def reset_phone_id_verification(uid) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]

    @base_resource <> "/manage/account/" <> uid <> "/invalidatephone"
      |> put_request(%{}, headers)
  end

  @doc """
  DELETE - Remove Phone ID by Access Token:
  Deletes the Phone ID on a user's account using access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/phone-authentication/remove-phone-id-by-access-token
  """
  @spec remove_phone_id_by_access_token(String.t()) :: LoginRadius.lr_response()
  def remove_phone_id_by_access_token(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/auth/phone"
      |> delete_request(%{}, headers)
  end
end
