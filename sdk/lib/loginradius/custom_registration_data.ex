defmodule LoginRadius.CustomRegistrationData do
  @moduledoc """
  Elixir wrapper for the LoginRadius Custom Registration Data API module
  """

  @base_resource "/identity/v2"
  @apisecret Application.fetch_env!(:loginradius, :apisecret)
  @default_headers [
    {"Content-Type", "application/json"}
  ]
  @default_params [
    {"apikey", Application.fetch_env!(:loginradius, :apikey)}
  ]

  @spec post_request(String.t(), map(), list(), list()) :: LoginRadius.lr_response()
  defp post_request(resource, data, headers \\ [], params \\ []) do
    LoginRadius.post_request(
      resource,
      "api",
      data,
      @default_headers ++ headers,
      @default_params ++ params
    )
  end

  @spec get_request(String.t(), list(), list()) :: LoginRadius.lr_response()
  defp get_request(resource, headers, params) do
    LoginRadius.get_request(
      resource,
      "api",
      headers,
      @default_params ++ params
    ) 
  end

  @spec put_request(String.t(), map(), list()) :: LoginRadius.lr_response()
  defp put_request(resource, data, headers, params \\ []) do
    LoginRadius.put_request(
      resource,
      "api",
      data,
      @default_headers ++ headers,
      @default_params ++ params
    )
  end

  @spec delete_request(String.t(), list()) :: LoginRadius.lr_response()
  defp delete_request(resource, headers) do
    LoginRadius.delete_request(
      resource,
      "api",
      %{},
      @default_headers ++ headers,
      @default_params
    )
  end

  @doc """
  POST - Add Registration Data:
  Adds data to your custom DropDownList configured for user registration.
  https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/add-registration-data
  """
  @spec add_registration_data(map()) :: LoginRadius.lr_response()
  def add_registration_data(data) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]

    @base_resource <> "/manage/registrationdata"
      |> post_request(data, headers)
  end

  @doc """
  POST - Validate Code:
  Validates code for a particular dropdown member.
  https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/validate-code
  """
  @spec validate_code(map()) :: LoginRadius.lr_response()
  def validate_code(data) do
    @base_resource <> "/auth/registrationdata/validatecode"
      |> post_request(data)
  end

  @doc """
  GET - Get Registration Data:
  Retrieves dropdown data. Needs API secret.
  https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/get-registration-data
  """
  @spec get_registration_data(String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def get_registration_data(type, parent_id \\ "", skip \\ "", limit \\ "") do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"parentid", parent_id},
      {"skip", skip},
      {"limit", limit}
    ]

    @base_resource <> "/manage/registrationdata/" <> type
      |> get_request(headers, query_params)
  end

  @doc """
  GET - Auth Get Registration Data:
  Retrieves dropdown data. No API secret required.
  https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/auth-get-registration-data
  """
  @spec auth_get_registration_data(String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def auth_get_registration_data(type, parent_id \\ "", skip \\ "", limit \\ "") do
    query_params = [
      {"parentid", parent_id},
      {"skip", skip},
      {"limit", limit}
    ]

    @base_resource <> "/auth/registrationdata/" <> type
      |> get_request([], query_params)
  end

  @doc """
  PUT - Update Registration Data:
  Updates a member of configured DropDownList.
  https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/update-registration-data
  """
  @spec update_registration_data(String.t(), map()) :: LoginRadius.lr_response()
  def update_registration_data(record_id, data) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]

    @base_resource <> "/manage/registrationdata/" <> record_id
      |> put_request(data, headers)
  end

  @doc """
  DELETE - Delete Registration Data:
  Deletes a member of configured DropDownList.
  https://docs.loginradius.com/api/v2/customer-identity-api/custom-registration-data/delete-registration-data
  """
  @spec delete_registration_data(String.t()) :: LoginRadius.lr_response()
  def delete_registration_data(record_id) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]

    @base_resource <> "/manage/registrationdata/" <> record_id
      |> delete_request(headers)
  end
end
