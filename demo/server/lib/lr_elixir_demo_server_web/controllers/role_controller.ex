defmodule LrElixirDemoServerWeb.RoleController do
  use LrElixirDemoServerWeb, :controller

  def create_role(conn, params) do
    response = params
      |> LoginRadius.RolesManagement.roles_create()
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def roles_list(conn, _) do
    response = LoginRadius.RolesManagement.roles_list()
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)
    
    json(put_status(conn, status_code), data)
  end

  def roles_by_uid(conn, params) do
    response = params
      |> Map.fetch!("uid")
      |> LoginRadius.RolesManagement.roles_by_uid()
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def assign_role_by_uid(conn, params) do
    body = params
      |> Map.delete("uid")
    response = params
      |> Map.fetch!("uid")
      |> LoginRadius.RolesManagement.assign_roles_by_uid(body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)
    
    json(put_status(conn, status_code), data)
  end

  def delete_role(conn, params) do
    response = params
      |> Map.fetch!("role")
      |> LoginRadius.RolesManagement.delete_role()
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end
end
