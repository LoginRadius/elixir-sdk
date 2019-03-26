defmodule LrElixirDemoServerWeb.Router do
  use LrElixirDemoServerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", LrElixirDemoServerWeb do
    pipe_through :api

    post "/login/email", LoginController, :email_login
    post "/forgotpassword", LoginController, :forgot_password
    get "/login/passwordless", LoginController, :passwordless_login
    get "/login/passwordless/auth", LoginController, :passwordless_auth
    put "/login/resetpassword", LoginController, :reset_password_by_reset_token

    post "/mfa/login/email", MfaController, :mfa_email_login
    get "/mfa/validate", MfaController, :mfa_validate_access_token
    put "/mfa/google/auth", MfaController, :mfa_auth_google
    put "/mfa/google/enable", MfaController, :mfa_enable_google_by_access_token
    delete "/mfa/google", MfaController, :mfa_reset_google

    post "/register", RegistrationController, :registration
    get "/register/verify/email", RegistrationController, :registration_verify_email

    get "/profile", ProfileController, :read_profile_by_token
    put "/profile/update", ProfileController, :account_update
    put "/profile/changepassword", ProfileController, :change_password
    put "/profile/setpassword", ProfileController, :set_password

    post "/roles", RoleController, :create_role
    get "/roles", RoleController, :roles_list
    get "/roles/get", RoleController, :roles_by_uid
    put "/roles", RoleController, :assign_role_by_uid
    delete "/roles", RoleController, :delete_role

    post "/customobj", CustomObjectController, :create_custom_object_by_access_token
    get "/customobj", CustomObjectController, :get_custom_object_by_access_token
    put "/customobj", CustomObjectController, :update_custom_object_by_access_token
    delete "/customobj", CustomObjectController, :delete_custom_object_by_access_token
  end
end
