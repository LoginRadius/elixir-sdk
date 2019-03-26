defmodule LoginRadius.Authentication do
  @moduledoc """
  Elixir wrapper for the LoginRadius Authentication API module
  """

  @base_resource "/identity/v2/auth"
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
  POST - Auth Add Email:
  Adds additional emails to a user's account.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-add-email
  """
  @spec add_email(String.t(), map(), String.t(), String.t()) :: LoginRadius.lr_response()
  def add_email(access_token, data, verification_url \\ "", email_template \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"verificationurl", verification_url},
      {"emailtemplate", email_template}
    ]

    @base_resource <> "/email"
      |> post_request(data, headers, query_params)
  end

  @doc """
  POST - Auth Forgot Password:
  Sends a reset password url to a specified account.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-forgot-password
  """
  @spec forgot_password(String.t(), map(), String.t()) :: LoginRadius.lr_response()
  def forgot_password(reset_password_url, data, email_template \\ "") do
    query_params = [
      {"resetpasswordurl", reset_password_url},
      {"emailtemplate", email_template}
    ]

    @base_resource <> "/password"
      |> post_request(data, [], query_params)
  end

  @doc """
  POST - Auth User Registration by Email:
  Creates a user in the database and sends a verification email to the user.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-user-registration-by-email
  """
  @spec user_registration_by_email(map(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def user_registration_by_email(data, verification_url \\ "", email_template \\ "", options \\ "") do
    headers = [
      {"X-LoginRadius-Sott", LoginRadius.Infrastructure.local_generate_sott()}
    ]
    query_params = [
      {"verificationurl", verification_url},
      {"emailtemplate", email_template},
      {"options", options}
    ]

    @base_resource <> "/register"
      |> post_request(data, headers, query_params)
  end

  @doc """
  POST - Auth Login by Email:
  Retrieves a copy of user data based on email.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-login-by-email
  """
  @spec login_by_email(map(), String.t(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_email(data, verification_url \\ "", login_url \\ "", email_template \\ "", g_recaptcha_response \\ "", options \\ "") do
    query_params = [
      {"verificationurl", verification_url},
      {"emailtemplate", email_template},
      {"loginurl", login_url},
      {"g-recaptcha-response", g_recaptcha_response},
      {"options", options}
    ]

    @base_resource <> "/login"
      |> post_request(data, [], query_params)
  end

  @doc """
  POST - Auth Login by Username:
  Retrieves a copy of user data based on username.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-login-by-username
  """
  @spec login_by_username(map(), String.t(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def login_by_username(data, verification_url \\ "", login_url \\ "", email_template \\ "", g_recaptcha_response \\ "", options \\ "") do
    query_params = [
      {"verificationurl", verification_url},
      {"emailtemplate", email_template},
      {"loginurl", login_url},
      {"g-recaptcha-response", g_recaptcha_response},
      {"options", options}
    ]

    @base_resource <> "/login"
      |> post_request(data, [], query_params)
  end

  @doc """
  GET - Auth Check Email Availability:
  Check if the specified email exists on your site.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-email-availability
  """
  @spec check_email_availability(String.t()) :: LoginRadius.lr_response()
  def check_email_availability(email) do
    query_params = [
      {"email", email}
    ]

    @base_resource <> "/email"
      |> get_request([], query_params)
  end

  @doc """
  GET - Auth Check Username Availability:
  Check if the specified username exists on your site.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-username-availability
  """
  @spec check_username_availability(String.t()) :: LoginRadius.lr_response()
  def check_username_availability(username) do
    query_params = [
      {"username", username}
    ]

    @base_resource <> "/username"
      |> get_request([], query_params)
  end

  @doc """
  GET - Auth Read All Profiles by Token:
  Retrieves a copy of user data based on access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-read-profiles-by-token
  """
  @spec read_profiles_by_access_token(String.t()) :: LoginRadius.lr_response()
  def read_profiles_by_access_token(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/account"
      |> get_request(headers)
  end

  @doc """
  GET - Auth Privacy Policy Accept:
  Updates the privacy policy status in a user's profile based on access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-privacy-policy-accept
  """
  @spec privacy_policy_accept(String.t()) :: LoginRadius.lr_response()
  def privacy_policy_accept(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/privacypolicy/accept"
      |> get_request(headers)
  end

  @doc """
  GET - Auth Send Welcome Email:
  Sends a welcome email.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-send-welcome-email
  """
  @spec send_welcome_email(String.t(), String.t()) :: LoginRadius.lr_response()
  def send_welcome_email(access_token, welcome_email_template \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"welcomeemailtemplate", welcome_email_template}
    ]

    @base_resource <> "/account/sendwelcomeemail"
      |> get_request(headers, query_params)
  end

  @doc """
  GET - Auth Social Identity:
  Prevents RAAS profile of the second account from getting created (called before account linking API).
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-social-identity
  """
  @spec social_identity(String.t()) :: LoginRadius.lr_response()
  def social_identity(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/socialidentity"
      |> get_request(headers)
  end

  @doc """
  GET - Validate Access Token:
  Validates access token, returns an error if token is invalid.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-validate-access-token
  """
  @spec validate_access_token(String.t()) :: LoginRadius.lr_response()
  def validate_access_token(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/access_token/validate"
      |> get_request(headers)
  end

  @doc """
  GET - Auth Verify Email:
  Verifies the email of a user.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-verify-email
  """
  @spec verify_email(String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def verify_email(verification_token, url \\ "", welcome_email_template \\ "") do
    query_params = [
      {"verificationtoken", verification_token},
      {"url", url},
      {"welcomeemailtemplate", welcome_email_template}
    ]

    @base_resource <> "/email"
      |> get_request([], query_params)
  end

  @doc """
  GET - Auth Delete Account:
  Delete an account based on delete token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-delete-account
  """
  @spec delete_account(String.t()) :: LoginRadius.lr_response()
  def delete_account(delete_token) do
    query_params = [
      {"deletetoken", delete_token}
    ]

    @base_resource <> "/account/delete"
      |> get_request([], query_params)
  end

  @doc """
  GET - Invalidate Access Token:
  Invalidates an active access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-invalidate-access-token
  """
  @spec invalidate_access_token(String.t()) :: LoginRadius.lr_response()
  def invalidate_access_token(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/access_token/invalidate"
      |> get_request(headers)
  end

  @doc """
  GET - Get Security Questions by Access Token:
  Retrieves the list of security questions that have been configured for an account
  by access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/security-questions-by-access-token
  """
  @spec security_questions_by_access_token(String.t()) :: LoginRadius.lr_response()
  def security_questions_by_access_token(access_token) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/securityquestion/accesstoken"
      |> get_request(headers)
  end

  @doc """
  GET - Get Security Questions by Email:
  Retrieves the list of security questions that have been configured for an account
  by email.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/security-questions-by-email
  """
  @spec security_questions_by_email(String.t()) :: LoginRadius.lr_response()
  def security_questions_by_email(email) do
    query_params = [
      {"email", email}
    ]

    @base_resource <> "/securityquestion/email"
      |> get_request([], query_params)
  end

  @doc """
  GET - Get Security Questions by Username:
  Retrieves the list of security questions that have been configured for an account
  by username.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/security-questions-by-user-name
  """
  @spec security_questions_by_username(String.t()) :: LoginRadius.lr_response()
  def security_questions_by_username(username) do
    query_params = [
      {"username", username}
    ]

    @base_resource <> "/securityquestion/username"
      |> get_request([], query_params)
  end

  @doc """
  GET - Get Security Questions by Phone:
  Retrieves the list of security questions that have been configured for an account
  by phone ID.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/security-questions-by-phone
  """
  @spec security_questions_by_phone(String.t()) :: LoginRadius.lr_response()
  def security_questions_by_phone(phone_id) do
    query_params = [
      {"phone", phone_id}
    ]

    @base_resource <> "/securityquestion/phone"
      |> get_request([], query_params)
  end

  @doc """
  PUT - Auth Verify Email by OTP:
  Verifies the email of a user when OTP Email verification flow is enabled.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-verify-email-by-otp
  """
  @spec verify_email_by_otp(map, String.t(), String.t()) :: LoginRadius.lr_response()
  def verify_email_by_otp(data, url \\ "", welcome_email_template \\ "") do
    query_params = [
      {"url", url},
      {"welcomeemailtemplate", welcome_email_template}
    ]

    @base_resource <> "/email"
      |> put_request(data, [], query_params)
  end

  @doc """
  PUT - Auth Change Password:
  Changes an account's password based on previous password.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-change-password
  """
  @spec change_password(String.t(), map()) :: LoginRadius.lr_response()
  def change_password(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/password/change"
      |> put_request(data, headers)
  end

  @doc """
  PUT - Auth Link Social Identities:
  Links a social provider account with a specified account based on access token and social
  provider's user access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-link-social-identities
  """
  @spec link_social_identities(String.t(), map()) :: LoginRadius.lr_response()
  def link_social_identities(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/socialidentity"
      |> put_request(data, headers)
  end

  @doc """
  PUT - Auth Resend Email Verification:
  Resends a verification email to the user.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-resend-email-verification
  """
  @spec resend_email_verification(map(), String.t(), String.t()) :: LoginRadius.lr_response()
  def resend_email_verification(data, verification_url \\ "", email_template \\ "") do
    query_params = [
      {"verificationurl", verification_url},
      {"emailtemplate", email_template}
    ]

    @base_resource <> "/register"
      |> put_request(data, [], query_params)
  end

  @doc """
  PUT - Auth Reset Password by Reset Token:
  Sets a new password for a specified account using a reset token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-reset-token
  """
  @spec reset_password_by_reset_token(map()) :: LoginRadius.lr_response()
  def reset_password_by_reset_token(data) do
    @base_resource <> "/password/reset"
      |> put_request(data)
  end

  @doc """
  PUT - Auth Reset Password by OTP:
  Sets a new password for a specified account using a One Time Passcode.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-otp
  """
  @spec reset_password_by_otp(map()) :: LoginRadius.lr_response()
  def reset_password_by_otp(data) do
    @base_resource <> "/password/reset"
      |> put_request(data)
  end

  @doc """
  PUT - Auth Reset Password by Security Answer and Email:
  Sets a new password for a specified account using a security answer and email.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-email
  """
  @spec reset_password_by_security_answer_and_email(map()) :: LoginRadius.lr_response()
  def reset_password_by_security_answer_and_email(data) do
    @base_resource <> "/password/securityanswer"
      |> put_request(data)
  end

  @doc """
  PUT - Auth Reset Password by Security Answer and Phone:
  Sets a new password for a specified account using a security answer and phone.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-phone
  """
  @spec reset_password_by_security_answer_and_phone(map()) :: LoginRadius.lr_response()
  def reset_password_by_security_answer_and_phone(data) do
    @base_resource <> "/password/securityanswer"
      |> put_request(data)
  end

  @doc """
  PUT - Auth Reset Password by Security Answer and UserName:
  Sets a new password for a specified account using a security answer and username.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-reset-password-by-username
  """
  @spec reset_password_by_security_answer_and_username(map()) :: LoginRadius.lr_response()
  def reset_password_by_security_answer_and_username(data) do
    @base_resource <> "/password/securityanswer"
      |> put_request(data)
  end

  @doc """
  PUT - Set or Change UserName:
  Sets or changes a username using an access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-set-or-change-user-name
  """
  @spec set_or_change_username(String.t(), map()) :: LoginRadius.lr_response()
  def set_or_change_username(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/username"
      |> put_request(data, headers)
  end

  @doc """
  PUT - Auth Update Profile by Access Token:
  Updates a user's profile using an access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-update-profile-by-token
  """
  @spec update_profile_by_access_token(String.t(), map(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def update_profile_by_access_token(access_token, data, verification_url \\ "", email_template \\ "", sms_template \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"verificationurl", verification_url},
      {"emailtemplate", email_template},
      {"smstemplate", sms_template}
    ]

    @base_resource <> "/account"
      |> put_request(data, headers, query_params)
  end

  @doc """
  PUT - Update Security Questions by Access Token:
  Updates security questions using an access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-update-security-question-by-access-token
  """
  @spec update_security_questions_by_access_token(String.t(), map()) :: LoginRadius.lr_response()
  def update_security_questions_by_access_token(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/account"
      |> put_request(data, headers)
  end

  @doc """
  DELETE - Auth Delete Account with Email Confirmation:
  Deletes a user account using its access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-delete-account-with-email-confirmation
  """
  @spec delete_account_with_email_confirmation(String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def delete_account_with_email_confirmation(access_token, delete_url \\ "", email_template \\ "") do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"deleteurl", delete_url},
      {"emailtemplate", email_template}
    ]

    @base_resource <> "/account"
      |> delete_request(%{}, headers, query_params)
  end

  @doc """
  DELETE - Auth Remove Email:
  Removes additional emails from a user's account.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-remove-email
  """
  @spec remove_email(String.t(), map()) :: LoginRadius.lr_response()
  def remove_email(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/email"
      |> delete_request(data, headers)
  end

  @doc """
  DELETE - Auth Unlink Social Identities:
  Unlinks a social provider account with a specified account using its access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/authentication/auth-unlink-social-identities
  """
  @spec unlink_social_identities(String.t(), map()) :: LoginRadius.lr_response()
  def unlink_social_identities(access_token, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]

    @base_resource <> "/socialidentity"
      |> delete_request(data, headers)
  end
end
