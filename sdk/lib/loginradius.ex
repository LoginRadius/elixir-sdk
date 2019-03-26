defmodule LoginRadius do
  use HTTPoison.Base
  @moduledoc """
  LoginRadius parent module, helper functions are located here.
  """

  @type lr_response :: {:ok, {integer(), map(), HTTPoison.Response.t()}} | {:error, {integer(), map(), HTTPoison.Response.t()}}

  @api_v2_base_url "https://api.loginradius.com"
  @api_v2_base_url_config "https://config.lrcontent.com"
  @api_v2_base_url_cloud "https://cloud-api.loginradius.com"
  
  @default_headers [
    {"Accept-Encoding", "gzip"}
  ]

  @custom_timeout 120000

  def process_response_body(body) do
    Poison.decode!(body)
  end

  @doc """
  Sends a POST api request.
  """
  @spec post_request(String.t(), String.t(), map(), list(), list()) :: lr_response()
  def post_request(resource, type, data, headers, params) do
    LoginRadius.post!(
      build_url!(resource, type),
      Poison.encode!(data),
      @default_headers ++ headers,
      params: params,
      timeout: @custom_timeout,
      recv_timeout: @custom_timeout
    )
      |> handle_response()
  end

  @doc """
  Sends a GET api request.
  """
  @spec get_request(String.t(), String.t(), list(), list()) :: lr_response()
  def get_request(resource, type, headers, params) do
    LoginRadius.get!(
      build_url!(resource, type),
      @default_headers ++ headers,
      params: params,
      timeout: @custom_timeout,
      recv_timeout: @custom_timeout
    )
      |> handle_response()
  end

  @doc """
  Sends a PUT api request.
  """
  @spec put_request(String.t(), String.t(), map(), list(), list()) :: lr_response()
  def put_request(resource, type, data, headers, params) do
    LoginRadius.put!(
      build_url!(resource, type),
      Poison.encode!(data),
      @default_headers ++ headers,
      params: params,
      timeout: @custom_timeout,
      recv_timeout: @custom_timeout
    )
      |> handle_response()
  end

  @doc """
  Sends a DELETE api request.
  """
  @spec delete_request(String.t(), String.t(), map(), list(), list()) :: lr_response()
  def delete_request(resource, type, data, headers, params) do
    :delete
      |> LoginRadius.request!(
          build_url!(resource, type),
          Poison.encode!(data),
          @default_headers ++ headers,
          params: params,
          timeout: @custom_timeout,
          recv_timeout: @custom_timeout
         )
      |> handle_response()
  end

  @doc """
  Handles a HTTPoison.Response, return :error tuple if response is 4xx or 5xx,
  :ok otherwise.
  """
  @spec handle_response(HTTPoison.Response.t()) :: lr_response()
  def handle_response(response = %HTTPoison.Response{status_code: status_code, body: body}) do
    code_to_match = Integer.to_string(status_code)

    cond do
      Regex.match?(~r/^[4-5][0-9][0-9]$/, code_to_match) ->
        {:error, {status_code, body, response}}
      true ->
        {:ok, {status_code, body, response}}
    end
  end

  @doc """
  Builds the target url based on resource and url type, raises ArgumentError if type is
  invalid.
  """
  @spec build_url!(String.t(), String.t()) :: String.t()
  def build_url!(resource, type) do
    custom_api_domain = Application.fetch_env!(:loginradius, :customapidomain)

    case type do
      "api" ->
        if custom_api_domain == "" do
          URI.encode(@api_v2_base_url <> resource)
        else
          URI.encode(custom_api_domain <> resource)
        end
      "cloud" ->
        URI.encode(@api_v2_base_url_cloud <> resource)
      "config" ->
        URI.encode(@api_v2_base_url_config <> resource)
      _ ->
        raise ArgumentError, message: "Url type must be either 'api', 'cloud', or 'config'."
    end
  end
end
