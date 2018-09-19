defmodule LrElixirDemoServerWeb.LoginController do
  use LrElixirDemoServerWeb, :controller

  def email_login(conn, params) do
    verification_url = params
      |> Map.fetch!("verification_url")
    body = params
      |> Map.delete("verification_url")
    response = LoginRadius.Authentication.login_by_email(body, verification_url)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def passwordless_login(conn, params) do
    verification_url = params
      |> Map.fetch!("verification_url")

    response = 
      cond do
        Map.has_key?(params, "email") ->
          params
            |> Map.fetch!("email")
            |> LoginRadius.PasswordlessLogin.login_by_email("oneclicksignin-default", verification_url)
            |> elem(1)
        Map.has_key?(params, "username") ->
          params
            |> Map.fetch!("username")
            |> LoginRadius.PasswordlessLogin.login_by_username("oneclicksignin-default", verification_url)
            |> elem(1)
        true ->
          {400, %{"Description"=>"Request is missing a required parameter"}, %{}}
      end

    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def passwordless_auth(conn, params) do
    response = params
      |> Map.fetch!("verification_token")
      |> LoginRadius.PasswordlessLogin.login_verification("welcome-default")
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def forgot_password(conn, params) do
    reset_password_url = params
      |> Map.fetch!("reset_password_url")
    body = params
      |> Map.delete("reset_password_url")
    response = LoginRadius.Authentication.forgot_password(reset_password_url, body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def reset_password_by_reset_token(conn, params) do
    response = params
      |> LoginRadius.Authentication.reset_password_by_reset_token()
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end
end
