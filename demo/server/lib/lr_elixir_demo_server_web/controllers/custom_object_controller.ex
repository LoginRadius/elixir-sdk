defmodule LrElixirDemoServerWeb.CustomObjectController do
  use LrElixirDemoServerWeb, :controller

  def create_custom_object_by_access_token(conn, params) do
    obj_name = params
      |> Map.fetch!("object_name")
    body = params
      |> Map.delete("object_name")
      |> Map.delete("auth")
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.CustomObjectManagement.create_by_access_token(obj_name, body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def update_custom_object_by_access_token(conn, params) do
    obj_name = params
      |> Map.fetch!("object_name")
    obj_id = params
      |> Map.fetch!("object_id")
    body = params
      |> Map.delete("object_name")
      |> Map.delete("object_id")
      |> Map.delete("auth")
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.CustomObjectManagement.update_by_objectrecordid_and_access_token(obj_id, obj_name, "partialreplace", body)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def get_custom_object_by_access_token(conn, params) do
    obj_name = params
      |> Map.fetch!("object_name")
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.CustomObjectManagement.get_by_access_token(obj_name)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)

    json(put_status(conn, status_code), data)
  end

  def delete_custom_object_by_access_token(conn, params) do
    obj_name = params
      |> Map.fetch!("object_name")
    obj_id = params
      |> Map.fetch!("object_id")
    response = params
      |> Map.fetch!("auth")
      |> LoginRadius.CustomObjectManagement.delete_by_objectrecordid_and_access_token(obj_id, obj_name)
      |> elem(1)
    status_code = response
      |> elem(0)
    data = response
      |> elem(1)
    
    json(put_status(conn, status_code), data)
  end
end
