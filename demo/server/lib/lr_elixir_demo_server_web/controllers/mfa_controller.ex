defmodule LrElixirDemoServerWeb.MfaController do
  use LrElixirDemoServerWeb, :controller

  def mfa_email_login(conn, params) do
    verification_url = params
      |> Map.fetch!("verification_url")
    body = params
      |> Map.delete("verification_url")
    response = LoginRadius.MultiFactorAuthentication.login_by_email(body, "", verification_url)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def mfa_auth_google(conn, params) do
    body = params
      |> Map.delete("multi_factor_auth_token")
    response = params
      |> Map.fetch!("multi_factor_auth_token")
      |> LoginRadius.MultiFactorAuthentication.validate_google_auth_code(body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def mfa_reset_google(conn, params) do
    body = params
      |> Map.delete("auth")
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.MultiFactorAuthentication.reset_google_authenticator_by_access_token(body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def mfa_enable_google_by_access_token(conn, params) do
    body = params
      |> Map.delete("auth")
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.MultiFactorAuthentication.update_mfa_by_access_token(body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def mfa_validate_access_token(conn, params) do
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.MultiFactorAuthentication.validate_access_token()
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end
end
