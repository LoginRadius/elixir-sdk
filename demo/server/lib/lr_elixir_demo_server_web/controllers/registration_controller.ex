defmodule LrElixirDemoServerWeb.RegistrationController do
  use LrElixirDemoServerWeb, :controller

  def registration(conn, params) do
    body = params
      |> Map.delete("verification_url")
    verification_url = params
      |> Map.fetch!("verification_url")
    response = LoginRadius.Authentication.user_registration_by_email(body, verification_url, "verification-default")
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def registration_verify_email(conn, params) do
    response = params
      |> Map.fetch!("verification_token")
      |> LoginRadius.Authentication.verify_email("", "welcome-default")
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end
end
