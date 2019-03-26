defmodule LoginRadius.Account do
  @moduledoc """
  Elixir wrapper for the LoginRadius Account API module
  """
  
  @base_resource "/identity/v2/manage/account"
  @default_headers [
    {"Content-Type", "application/json"},
    {"X-LoginRadius-ApiSecret", Application.fetch_env!(:loginradius, :apisecret)}
  ]
  @default_params [
    {"apikey", Application.fetch_env!(:loginradius, :apikey)}
  ]

  @spec post_request(String.t(), map(), list()) :: LoginRadius.lr_response()
  defp post_request(resource, data, params \\ []) do
    LoginRadius.post_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params ++ params
    )
  end

  @spec get_request(String.t(), list()) :: LoginRadius.lr_response()
  defp get_request(resource, params \\ []) do
    LoginRadius.get_request(
      resource,
      "api",
      @default_headers,
      @default_params ++ params
    ) 
  end

  @spec put_request(String.t(), map(), list()) :: LoginRadius.lr_response()
  defp put_request(resource, data, params \\ []) do
    LoginRadius.put_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params ++ params
    )
  end

  @spec delete_request(String.t(), map(), list()) :: LoginRadius.lr_response()
  defp delete_request(resource, data \\ %{}, params \\ []) do
    LoginRadius.delete_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params ++ params
    )
  end

  @doc """
  POST - Account Create:
  Creates an account in LoginRadius Cloud Storage, bypassing the normal
  email verification process.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-create
  """
  @spec create(map()) :: LoginRadius.lr_response()
  def create(data) do
    @base_resource
      |> post_request(data)
  end

  @doc """
  POST - Email Verification Token:
  Retrieves an Email Verification token.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/get-email-verification-token
  """
  @spec email_verification_token(map()) :: LoginRadius.lr_response()
  def email_verification_token(data) do
    @base_resource <> "/verify/token"
      |> post_request(data)
  end

  @doc """
  POST - Forgot Password Token:
  Retrieves a Forgot Password token.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/get-forgot-password-token
  """
  @spec forgot_password_token(map()) :: LoginRadius.lr_response()
  def forgot_password_token(data) do
    @base_resource <> "/forgot/token"
      |> post_request(data)
  end
  
  @doc """
  GET - Account Identities by Email:
  Retrieves all identities associated with a specified email.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-identities-by-email
  """
  @spec identities_by_email(String.t()) :: LoginRadius.lr_response()
  def identities_by_email(email) do
    @base_resource <> "/identities"
      |> get_request([{"email", email}])
  end

  @doc """
  GET - Access Token Based on UID or User Impersonation:
  Retrieves a LoginRadius access token based on UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-impersonation-api
  """
  @spec user_impersonation(String.t()) :: LoginRadius.lr_response()
  def user_impersonation(uid) do
    @base_resource <> "/access_token"
      |> get_request([{"uid", uid}])
  end

  @doc """
  GET - Account Password:
  Retrieves the hashed password of an account based on UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-password
  """
  @spec password(String.t()) :: LoginRadius.lr_response()
  def password(uid) do
    @base_resource <> "/" <> uid <> "/password"
      |> get_request()
  end

  @doc """
  GET - Account Profiles by Email:
  Retrieves profile data based on email.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-profiles-by-email
  """
  @spec profiles_by_email(String.t()) :: LoginRadius.lr_response()
  def profiles_by_email(email) do
    @base_resource
      |> get_request([{"email", email}])
  end

  @doc """
  GET - Account Profiles by UserName:
  Retrieves profile data based on username.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-profiles-by-user-name
  """
  @spec profiles_by_username(String.t()) :: LoginRadius.lr_response()
  def profiles_by_username(username) do
    @base_resource
      |> get_request([{"username", username}])
  end

  @doc """
  GET - Account Profiles by Phone ID:
  Retrieves profile data based on phone ID.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-profiles-by-phone-id
  """
  @spec profiles_by_phoneid(String.t()) :: LoginRadius.lr_response()
  def profiles_by_phoneid(phone_id) do
    @base_resource
      |> get_request([{"phone", phone_id}])
  end

  @doc """
  GET - Account Profiles by UID:
  Retrieves profile data based on UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-profiles-by-uid
  """
  @spec profiles_by_uid(String.t()) :: LoginRadius.lr_response()
  def profiles_by_uid(uid) do
    @base_resource <> "/" <> uid
      |> get_request()
  end

  @doc """
  PUT - Account Set Password:
  Sets the password of an account.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-set-password
  """
  @spec set_password(String.t(), map()) :: LoginRadius.lr_response()
  def set_password(uid, data) do
    @base_resource <> "/" <> uid <> "/password"
      |> put_request(data)
  end

  @doc """
  PUT - Account Update:
  Updates the information of an existing account based on UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-update
  """
  @spec update(String.t(), map(), boolean()) :: LoginRadius.lr_response()
  def update(uid, data, nullsupport \\ false) do
    @base_resource <> "/" <> uid
      |> put_request(data, [{"nullsupport", nullsupport}])
  end

  @doc """
  PUT - Account Update Security Question Configuration:
  Updates the security questions configuration of an existing account based on UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-update-security-question
  """
  @spec update_security_question_configuration(String.t(), map()) :: LoginRadius.lr_response()
  def update_security_question_configuration(uid, data) do
    @base_resource <> "/" <> uid
      |> put_request(data)
  end

  @doc """
  PUT - Account Invalidate Verification Status:
  Invalidates the Email Verification status of an account.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-invalidate-verification-email
  """
  @spec invalidate_verification_status(String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def invalidate_verification_status(uid, verification_url \\ "", email_template \\ "") do
    @base_resource <> "/" <> uid <> "/invalidateemail"
      |> put_request(%{}, [{"verificationurl", verification_url}, {"emailtemplate", email_template}])
  end

  @doc """
  DELETE - Account Email Delete:
  Removes an email on an existing account based on UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-email-delete
  """
  @spec email_delete(String.t(), map()) :: LoginRadius.lr_response()
  def email_delete(uid, data) do
    @base_resource <> "/" <> uid <> "/email"
      |> delete_request(data)
  end

  @doc """
  DELETE - Account Delete:
  Removes an existing user account based on UID.
  https://docs.loginradius.com/api/v2/customer-identity-api/account/account-delete
  """
  @spec delete(String.t()) :: LoginRadius.lr_response()
  def delete(uid) do
    @base_resource <> "/" <> uid
      |> delete_request()
  end
end
