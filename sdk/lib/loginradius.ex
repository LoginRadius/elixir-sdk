defmodule LoginRadius do
  use HTTPoison.Base
  @moduledoc """
  LoginRadius parent module, helper functions are located here.
  """

  @type response :: {:ok, {integer(), map(), HTTPoison.Response.t()}} | {:error, {integer(), map(), HTTPoison.Response.t()}}

  @base_url "https://api.loginradius.com"

  def process_response_body(body) do
    Poison.decode!(body)
  end

  @doc """
  Sends a POST api request.
  """
  @spec post_request(String.t(), map(), list(), list()) :: response()
  def post_request(resource, data, headers, params) do
    LoginRadius.post!(
      URI.encode(@base_url <> resource),
      Poison.encode!(data),
      headers,
      params: params    
    )
      |> handle_response()
  end

  @doc """
  Sends a GET api request.
  """
  @spec get_request(String.t(), list(), list()) :: response()
  def get_request(resource, headers, params) do
    LoginRadius.get!(
      @base_url <> resource,
      headers,
      params: params
    )
      |> handle_response()
  end

  @doc """
  Sends a PUT api request.
  """
  @spec put_request(String.t(), map(), list(), list()) :: response()
  def put_request(resource, data, headers, params) do
    LoginRadius.put!(
      @base_url <> resource,
      Poison.encode!(data),
      headers,
      params: params
    )
      |> handle_response()
  end

  @doc """
  Sends a DELETE api request.
  """
  @spec delete_request(String.t(), map(), list(), list()) :: response()
  def delete_request(resource, data, headers, params) do
    :delete
      |> LoginRadius.request!(
          @base_url <> resource,
          Poison.encode!(data),
          headers,
          params: params
         )
      |> handle_response()
  end

  @doc """
  Handles a HTTPoison.Response, return :error tuple if response is 4xx or 5xx,
  :ok otherwise
  """
  @spec handle_response(HTTPoison.Response.t()) :: response()
  def handle_response(response = %HTTPoison.Response{status_code: status_code, body: body}) do
    code_to_match = Integer.to_string(status_code)

    cond do
      Regex.match?(~r/^[4-5][0-9][0-9]$/, code_to_match) ->
        {:error, {status_code, body, response}}
      true ->
        {:ok, {status_code, body, response}}
    end
  end
end
