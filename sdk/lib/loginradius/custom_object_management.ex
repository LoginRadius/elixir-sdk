defmodule LoginRadius.CustomObjectManagement do
  @moduledoc """
  Elixir wrapper for the LoginRadius Custom Object Management API module.
  """

  @base_resource "/identity/v2"
  @apisecret Application.fetch_env!(:loginradius_elixir_sdk, :apisecret)
  @default_headers [
    {"Content-Type", "application/json"}
  ]
  @default_params [
    {"apikey", Application.fetch_env!(:loginradius_elixir_sdk, :apikey)}
  ]

  @spec post_request(String.t(), map(), list(), list()) :: LoginRadius.response()
  defp post_request(resource, data, headers, params) do
    LoginRadius.post_request(
      resource,
      data,
      @default_headers ++ headers,
      @default_params ++ params
    )
  end

  @spec get_request(String.t(), list(), list()) :: LoginRadius.response()
  defp get_request(resource, headers, params) do
    LoginRadius.get_request(
      resource,
      @default_headers ++ headers,
      @default_params ++ params
    ) 
  end

  @spec put_request(String.t(), map(), list(), list()) :: LoginRadius.response()
  defp put_request(resource, data, headers, params) do
    LoginRadius.put_request(
      resource,
      data,
      @default_headers ++ headers,
      @default_params ++ params
    )
  end

  @spec delete_request(String.t(), list(), list()) :: LoginRadius.response()
  defp delete_request(resource, headers, params) do
    LoginRadius.delete_request(
      resource,
      %{},
      @default_headers ++ headers,
      @default_params ++ params
    )
  end

  @doc """
  POST - Create Custom Object by UID:
  Writes data to a custom object for a specified account by uid.
  https://docs.loginradius.com/api/v2/user-registration/create-custom-object-by-uid
  """
  @spec create_by_uid(String.t(), String.t(), map()) :: LoginRadius.response()
  def create_by_uid(uid, object_name, data) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"objectname", object_name}
    ]

    @base_resource <> "/manage/account/" <> uid <> "/customobject"
      |> post_request(data, headers, query_params)
  end

  @doc """
  POST - Create Custom Object by Access Token:
  Writes data to a custom object for a specified account by access token.
  https://docs.loginradius.com/api/v2/user-registration/create-custom-object-by-token
  """
  @spec create_by_access_token(String.t(), String.t(), map()) :: LoginRadius.response()
  def create_by_access_token(access_token, object_name, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"objectname", object_name}
    ]

    @base_resource <> "/auth/customobject"
      |> post_request(data, headers, query_params)
  end

  @doc """
  GET - Custom Object by ObjectRecordId and UID:
  Retrieves Custom Object data for a specified account by object name, id, and account uid.
  https://docs.loginradius.com/api/v2/user-registration/custom-object-by-objectrecordid-and-uid
  """
  @spec get_by_objectrecordid_and_uid(String.t(), String.t(), String.t()) :: LoginRadius.response()
  def get_by_objectrecordid_and_uid(uid, object_record_id, object_name) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"objectname", object_name}
    ]

    @base_resource <> "/manage/account/" <> uid <> "/customobject/" <> object_record_id
      |> get_request(headers, query_params)
  end

  @doc """
  GET - Custom Object by ObjectRecordId and Access Token:
  Retrieves Custom Object data for a specified account by object name, id, and access token.
  https://docs.loginradius.com/api/v2/user-registration/custom-object-by-objectrecordid-and-token
  """
  @spec get_by_objectrecordid_and_access_token(String.t(), String.t(), String.t()) :: LoginRadius.response()
  def get_by_objectrecordid_and_access_token(access_token, object_record_id, object_name) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"objectname", object_name}
    ]

    @base_resource <> "/auth/customobject/" <> object_record_id
      |> get_request(headers, query_params)
  end

  @doc """
  GET - Custom Object by Access Token:
  Retrieves Custom Object data for a specified account by object name and access token.
  https://docs.loginradius.com/api/v2/user-registration/custom-object-by-token
  """
  @spec get_by_access_token(String.t(), String.t()) :: LoginRadius.response()
  def get_by_access_token(access_token, object_name) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"objectname", object_name}
    ]

    @base_resource <> "/auth/customobject"
      |> get_request(headers, query_params)
  end

  @doc """
  GET - Custom Object by UID:
  Retrieves Custom Object data for a specified account by object name and account uid.
  https://docs.loginradius.com/api/v2/user-registration/custom-object-by-uid
  """
  @spec get_by_uid(String.t(), String.t()) :: LoginRadius.response()
  def get_by_uid(uid, object_name) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"objectname", object_name}
    ]

    @base_resource <> "/manage/account/" <> uid <> "/customobject"
      |> get_request(headers, query_params)
  end

  @doc """
  PUT - Custom Object Update by ObjectRecordId and UID:
  Updates Custom Object data for a specified account by object name, id, and account uid.
  If updatetype = replace, object will be replaced with new object. If updatetype = partialreplace,
  new object will be upserted(merged).
  https://docs.loginradius.com/api/v2/user-registration/custom-object-update-by-objectrecordid-and-uid
  """
  @spec update_by_objectrecordid_and_uid(String.t(), String.t(), String.t(), String.t(), map()) :: LoginRadius.response()
  def update_by_objectrecordid_and_uid(uid, object_record_id, object_name, update_type, data) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"objectname", object_name},
      {"updatetype", update_type}
    ]

    @base_resource <> "/manage/account/" <> uid <> "/customobject/" <> object_record_id
      |> put_request(data, headers, query_params)
  end

  @doc """
  PUT - Custom Object Update by ObjectRecordId and Access Token:
  Updates Custom Object data for a specified account by object name, id, and access token.
  If updatetype = replace, object will be replaced with new object. If updatetype = partialreplace,
  new object will be upserted(merged).
  https://docs.loginradius.com/api/v2/user-registration/custom-object-update-by-objectrecordid-and-token
  """
  @spec update_by_objectrecordid_and_access_token(String.t(), String.t(), String.t(), String.t(), map()) :: LoginRadius.response()
  def update_by_objectrecordid_and_access_token(access_token, object_record_id, object_name, update_type, data) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"objectname", object_name},
      {"updatetype", update_type}
    ]

    @base_resource <> "/auth/customobject/" <> object_record_id
      |> put_request(data, headers, query_params)
  end

  @doc """
  DELETE - Custom Object Delete by ObjectRecordId and UID:
  Deletes Custom Object data from a specified account by object name, id, and account uid.
  https://docs.loginradius.com/api/v2/user-registration/custom-object-delete-by-objectrecordid-and-uid
  """
  @spec delete_by_objectrecordid_and_uid(String.t(), String.t(), String.t()) :: LoginRadius.response()
  def delete_by_objectrecordid_and_uid(uid, object_record_id, object_name) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"objectname", object_name}
    ]

    @base_resource <> "/manage/account/" <> uid <> "/customobject/" <> object_record_id
      |> delete_request(headers, query_params)
  end

  @doc """
  DELETE - Custom Object Delete by ObjectRecordId and Access Token:
  Deletes Custom Object data from a specified account by object name, id, and access token.
  https://docs.loginradius.com/api/v2/user-registration/custom-object-delete-by-objectrecordid-and-token
  """
  @spec delete_by_objectrecordid_and_access_token(String.t(), String.t(), String.t()) :: LoginRadius.response()
  def delete_by_objectrecordid_and_access_token(access_token, object_record_id, object_name) do
    headers = [
      {"Authorization", "Bearer " <> access_token}
    ]
    query_params = [
      {"objectname", object_name}
    ]

    @base_resource <> "/auth/customobject/" <> object_record_id
      |> delete_request(headers, query_params)
  end
end
