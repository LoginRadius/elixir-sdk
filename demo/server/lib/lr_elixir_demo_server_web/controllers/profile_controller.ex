defmodule LrElixirDemoServerWeb.ProfileController do
  use LrElixirDemoServerWeb, :controller

  def read_profile_by_token(conn, params) do
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.Authentication.read_profiles_by_access_token()
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def change_password(conn, params) do
    body = params
      |> Map.delete("auth")
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.Authentication.change_password(body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)
    
    json(put_status(conn, status_code), data)
  end

  def set_password(conn, params) do
    body = params
      |> Map.delete("uid")
    response = params
      |> Map.fetch!("uid")
      |> LoginRadius.Account.set_password(body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def account_update(conn, params) do
    body = params
      |> Map.delete("uid")
    response = params
      |> Map.fetch!("uid")
      |> LoginRadius.Account.update(body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end
end
