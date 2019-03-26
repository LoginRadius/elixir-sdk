defmodule LoginRadius.RolesManagement do
  @moduledoc """
  Elixir wrapper for the LoginRadius Roles Management API module
  """

  @base_resource "/identity/v2/manage"
  @default_headers [
    {"Content-Type", "application/json"},
    {"X-LoginRadius-ApiSecret", Application.fetch_env!(:loginradius, :apisecret)}
  ]
  @default_params [
    {"apikey", Application.fetch_env!(:loginradius, :apikey)}
  ]

  @spec post_request(String.t(), map()) :: LoginRadius.lr_response()
  defp post_request(resource, data) do
    LoginRadius.post_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params
    )
  end

  @spec get_request(String.t()) :: LoginRadius.lr_response()
  defp get_request(resource) do
    LoginRadius.get_request(
      resource,
      "api",
      @default_headers,
      @default_params
    )
  end

  @spec put_request(String.t(), map()) :: LoginRadius.lr_response()
  defp put_request(resource, data) do
    LoginRadius.put_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params
    )
  end

  @spec delete_request(String.t(), map()) :: LoginRadius.lr_response()
  defp delete_request(resource, data \\ %{}) do
    LoginRadius.delete_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params
    )
  end

  @doc """
  POST - Roles Create:
  Creates roles with permissions.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/roles-create
  """
  @spec roles_create(map()) :: LoginRadius.lr_response()
  def roles_create(data) do
    @base_resource <> "/role"
      |> post_request(data)
  end

  @doc """
  GET - Get Context with Roles and Permissions:
  Retrieves the contexts which have been configured for a user and its associated roles and permissions.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/get-context
  """
  @spec get_contexts(String.t()) :: LoginRadius.lr_response()
  def get_contexts(uid) do
    @base_resource <> "/account/" <> uid <> "/rolecontext"
      |> get_request()
  end

  @doc """
  GET - Roles List:
  Retrieves complete list of created roles with permissions of your app.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/roles-list
  """
  @spec roles_list() :: LoginRadius.lr_response()
  def roles_list() do
    @base_resource <> "/role"
      |> get_request()
  end

  @doc """
  GET - Roles by UID:
  Retrieves all assigned roles of a particular user by uid.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/get-roles-by-uid
  """
  @spec roles_by_uid(String.t()) :: LoginRadius.lr_response()
  def roles_by_uid(uid) do
    @base_resource <> "/account/" <> uid <> "/role"
      |> get_request()
  end

  @doc """
  PUT - Add Permissions to Role:
  Adds permissions to a given role.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/add-permissions-to-role
  """
  @spec add_permissions_to_role(String.t(), map()) :: LoginRadius.lr_response()
  def add_permissions_to_role(role_name, data) do
    @base_resource <> "/role/" <> role_name <> "/permission"
      |> put_request(data)
  end

  @doc """
  PUT - Assign Roles by UID:
  Assigns created roles to a user.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/assign-roles-by-uid
  """
  @spec assign_roles_by_uid(String.t(), map()) :: LoginRadius.lr_response()
  def assign_roles_by_uid(uid, data) do
    @base_resource <> "/account/" <> uid <> "/role"
      |> put_request(data)
  end

  @doc """
  PUT - Upsert Context:
  Creates a context with a set of roles.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/upsert-context
  """
  @spec upsert_context(String.t(), map()) :: LoginRadius.lr_response()
  def upsert_context(uid, data) do
    @base_resource <> "/account/" <> uid <> "/rolecontext"
      |> put_request(data)
  end

  @doc """
  DELETE - Delete Role:
  Deletes a role given a role name.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/delete-role
  """
  @spec delete_role(String.t()) :: LoginRadius.lr_response()
  def delete_role(role_name) do
    @base_resource <> "/role/" <> role_name
      |> delete_request()
  end

  @doc """
  DELETE - Unassign Roles by UID:
  Unassigns roles from a user given uid.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/unassign-roles-by-uid
  """
  @spec unassign_roles_by_uid(String.t(), map()) :: LoginRadius.lr_response()
  def unassign_roles_by_uid(uid, data) do
    @base_resource <> "/account/" <> uid <> "/role"
      |> delete_request(data)
  end

  @doc """
  DELETE - Remove Permissions:
  Removes permissions from a role.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/remove-permissions
  """
  @spec remove_permissions(String.t(), map()) :: LoginRadius.lr_response()
  def remove_permissions(role_name, data) do
    @base_resource <> "/role/" <> role_name <> "/permission"
      |> delete_request(data)
  end

  @doc """
  DELETE - Delete Role Context:
  Deletes a specified role context given UID and role context name.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/delete-context
  """
  @spec delete_role_context(String.t(), String.t()) :: LoginRadius.lr_response()
  def delete_role_context(uid, role_context_name) do
    @base_resource <> "/account/" <> uid <> "/rolecontext/" <> role_context_name
      |> delete_request()
  end

  @doc """
  DELETE - Delete Role from Context
  Deletes a specified role from a context.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/delete-role-from-context
  """
  @spec delete_role_from_context(String.t(), String.t(), map()) :: LoginRadius.lr_response()
  def delete_role_from_context(uid, role_context_name, data) do
    @base_resource <> "/account/" <> uid <> "/rolecontext/" <> role_context_name <> "/role"
      |> delete_request(data)
  end

  @doc """
  DELETE - Delete Additional Permissions from Context
  Deletes additional permissions from context.
  https://docs.loginradius.com/api/v2/customer-identity-api/roles-management/delete-permissions-from-context
  """
  @spec delete_additional_permissions_from_context(String.t(), String.t(), map()) :: LoginRadius.lr_response()
  def delete_additional_permissions_from_context(uid, role_context_name, data) do
    @base_resource <> "/account/" <> uid <> "/rolecontext/" <> role_context_name <> "/additionalpermission"
      |> delete_request(data)
  end
end
