defmodule LoginRadius.MultiFactorAuthentication do
  @moduledoc """
  Elixir wrapper for the LoginRadius Multi Factor Authentication API module
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
  defp get_request(resource, headers, params \\ []) do
    LoginRadius.get_request(
      resource,
      "api",
      headers,
      @default_params ++ params
    )
  end

  @spec put_request(String.t(), map(), list(), list()) :: LoginRadius.lr_response()
  defp put_request(resource, data, headers, params \\ []) do
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
  POST - MFA Email Login:
  Logs in by Email ID on a Multi-Factor Authentication enabled site.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-email-login
  """
  @spec login_by_email(map(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_email(data, login_url \\ "", verification_url \\ "", email_template \\ "", sms_template_2fa \\ "") do
    query_params = [
      {"loginurl", login_url},
      {"verificationurl", verification_url},
      {"emailtemplate", email_template},
      {"smstemplate2fa", sms_template_2fa}
    ]

    @base_resource <> "/auth/login/2fa"
      |> post_request(data, [], query_params)
  end

  @doc """
  POST - MFA UserName Login:
  Logs in by Username on a MFA enabled site. API wrapper is identical to email,
  except data object contains username instead of email.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-user-name-login
  """
  @spec login_by_username(map(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_username(data, login_url \\ "", verification_url \\ "", email_template \\ "", sms_template_2fa \\ "") do
    query_params = [
      {"loginurl", login_url},
      {"verificationurl", verification_url},
      {"emailtemplate", email_template},
      {"smstemplate2fa", sms_template_2fa}
    ]

    @base_resource <> "/auth/login/2fa"
      |> post_request(data, [], query_params)
  end

  @doc """
  POST - MFA Phone Login:
  Logs in by Phone ID on a MFA enabled site. API wrapper is identical to email,
  except data object contains phone instead of email.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-phone-login
  """
  @spec login_by_phone(map(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_phone(data, login_url \\ "", verification_url \\ "", email_template \\ "", sms_template_2fa \\ "") do
    query_params = [
      {"loginurl", login_url},
      {"verificationurl", verification_url},
      {"emailtemplate", email_template},
      {"smstemplate2fa", sms_template_2fa}
    ]

    @base_resource <> "/auth/login/2fa"
      |> post_request(data, [], query_params)
  end

  @doc """
  GET - MFA Validate Access Token:
  Configures MFA after login using access token. (For MFA optional)
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-validate-access-token
  """
  @spec validate_access_token(String.t(), String.t()) :: LoginRadius.lr_response()
  def validate_access_token(access_token, sms_template_2fa \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"smstemplate2fa", sms_template_2fa}
    ]

    @base_resource <> "/auth/account/2fa"
      |> get_request(headers, query_params)
  end

  @doc """
  GET - MFA Backup Codes by Access Token:
  Retrieves a set of backup codes using access token to allow user login on a site with MFA enabled
  in the event that the user does not have a secondary factor available.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-backup-code-by-access-token
  """
  @spec backup_codes_by_access_token(String.t()) :: LoginRadius.lr_response()
  def backup_codes_by_access_token(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/auth/account/2fa/backupcode"
      |> get_request(headers)
  end

  @doc """
  GET - Reset Backup Codes by Access Token:
  Resets the backup codes on a given account using access token. 
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-backup-code-by-access-token
  """
  @spec reset_backup_codes_by_access_token(String.t()) :: LoginRadius.lr_response()
  def reset_backup_codes_by_access_token(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/auth/account/2fa/backupcode/reset"
      |> get_request(headers)
  end

  @doc """
  GET - MFA Backup Codes by UID:
  Retrieves a set of backup codes using UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-backup-code-by-uid
  """
  @spec backup_codes_by_uid(String.t()) :: LoginRadius.lr_response()
  def backup_codes_by_uid(uid) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"uid", uid}
    ]

    @base_resource <> "/manage/account/2fa/backupcode"
      |> get_request(headers, query_params)
  end

  @doc """
  GET - MFA Reset Backup Codes by UID:
  Resets the backup codes on a given account using UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-backup-code-by-uid
  """
  @spec reset_backup_codes_by_uid(String.t()) :: LoginRadius.lr_response()
  def reset_backup_codes_by_uid(uid) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"uid", uid}
    ]

    @base_resource <> "/manage/account/2fa/backupcode/reset"
      |> get_request(headers, query_params)
  end

  @doc """
  PUT - MFA Validate Backup Code:
  Validates the backup code provided by the user, returns an access token allowing user
  to login.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-validate-backup-code
  """
  @spec validate_backup_code(String.t(), map()) :: LoginRadius.lr_response()
  def validate_backup_code(second_factor_authentication_token, data) do
    query_params = [
      {"secondfactorauthenticationtoken", second_factor_authentication_token}
    ]

    @base_resource <> "/auth/login/2fa/verification/backupcode"
      |> put_request(data, [], query_params)
  end

  @doc """
  PUT - MFA Validate OTP:
  Validates the One Time Passcode received via SMS for use with MFA.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-validate-otp
  """
  @spec validate_otp(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def validate_otp(second_factor_authentication_token, data, sms_template_2fa \\ "") do
    query_params = [
      {"secondfactorauthenticationtoken", second_factor_authentication_token},
      {"smstemplate2fa", sms_template_2fa}
    ]

    @base_resource <> "/auth/login/2fa/verification/otp"
      |> put_request(data, [], query_params)
  end

  @doc """
  PUT - MFA Validate Google Auth Code:
  Validates google authenticator code for use with MFA.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-validate-google-auth-code
  """
  @spec validate_google_auth_code(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def validate_google_auth_code(second_factor_authentication_token, data, sms_template_2fa \\ "") do
    query_params = [
      {"secondfactorauthenticationtoken", second_factor_authentication_token},
      {"smstemplate2fa", sms_template_2fa}
    ]

    @base_resource <> "/auth/login/2fa/verification/googleauthenticatorcode"
      |> put_request(data, [], query_params)
  end

  @doc """
  PUT - MFA Update Phone Number:
  Updates (if configured) the phone number used for MFA. API authenticates using the second factor
  authentication token. Sends a verification OTP to provided phone number.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-update-phone-number
  """
  @spec update_phone_number(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def update_phone_number(second_factor_authentication_token, data, sms_template_2fa \\ "") do
    query_params = [
      {"secondfactorauthenticationtoken", second_factor_authentication_token},
      {"smstemplate2fa", sms_template_2fa}
    ]

    @base_resource <> "/auth/login/2fa"
      |> put_request(data, [], query_params)
  end

  @doc """
  PUT - MFA Update Phone Number by Access Token:
  Updates the MFA phone number by sending a verification OTP to the provided phone number. API authenticates
  using user's login access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-update-phone-number-by-token
  """
  @spec update_phone_number_by_access_token(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def update_phone_number_by_access_token(access_token, data, sms_template_2fa \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"smstemplate2fa", sms_template_2fa}
    ]

    @base_resource <> "/auth/account/2fa"
      |> put_request(data, headers, query_params)
  end

  @doc """
  PUT - Update MFA by Access Token:
  Enables Multi Factor Authentication by access token upon user login.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/update-mfa-by-access-token
  """
  @spec update_mfa_by_access_token(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def update_mfa_by_access_token(access_token, data, sms_template \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/auth/account/2fa/verification/googleauthenticatorcode"
      |> put_request(data, headers, query_params)
  end

  @doc """
  PUT - Update MFA Setting:
  Enables Multi Factor Authentication by OTP upon user login.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/update-mfa-setting
  """
  @spec update_mfa_setting(String.t(), map()) :: LoginRadius.lr_response()
  def update_mfa_setting(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/auth/account/2fa/verification/otp"
      |> put_request(data, headers)
  end

  @doc """
  DELETE - MFA Reset Google Authenticator by Access Token:
  Resets the Google Authenticator configurations on a given account using user's access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-google-authenticator-by-token
  """
  @spec reset_google_authenticator_by_access_token(String.t(), map()) :: LoginRadius.lr_response()
  def reset_google_authenticator_by_access_token(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/auth/account/2fa/authenticator"
      |> delete_request(data, headers)
  end

  @doc """
  DELETE - MFA Reset SMS Authenticator by Access Token:
  Resets the SMS Authenticator configurations on a given account using user's access token.
  Identical to Reset Google Authenticator by Access Token except data object has key otpauthenticator
  instead of googleauthenticator.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-sms-authenticator-by-token
  """
  @spec reset_sms_authenticator_by_access_token(String.t(), map()) :: LoginRadius.lr_response()
  def reset_sms_authenticator_by_access_token(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/auth/account/2fa/authenticator"
      |> delete_request(data, headers)
  end

  @doc """
  DELETE - MFA Reset Google Authenticator by UID:
  Resets the Google Authenticator configurations on a given account using user's UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-google-authenticator-by-uid
  """
  @spec reset_google_authenticator_by_uid(String.t(), map()) :: LoginRadius.lr_response()
  def reset_google_authenticator_by_uid(uid, data) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"uid", uid}
    ]

    @base_resource <> "/manage/account/2fa/authenticator"
      |> delete_request(data, headers, query_params)
  end

  @doc """
  DELETE - MFA Reset SMS Authenticator by UID:
  Resets the SMS Authenticator configurations on a given account using user's UID.
  Identical to Reset Google Authenticator by UID except data object has key otpauthenticator
  instead of googleauthenticator.
  https://docs.loginradius.com/api/v2/customer-identity-api/multi-factor-authentication/mfa-reset-sms-authenticator-by-uid
  """
  @spec reset_sms_authenticator_by_uid(String.t(), map()) :: LoginRadius.lr_response()
  def reset_sms_authenticator_by_uid(uid, data) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"uid", uid}
    ]
    
    @base_resource <> "/manage/account/2fa/authenticator"
      |> delete_request(data, headers, query_params)
  end
end
