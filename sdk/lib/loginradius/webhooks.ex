defmodule LoginRadius.Webhooks do
  @moduledoc """
  Elixir wrapper for the LoginRadius Webhooks API module.
  """
  
  @base_resource "/api/v2/webhook"
  @default_headers [{"Content-Type", "application/json"}]
  # Webhook APIs don't support API secrets in headers.
  @default_params [
    {"apikey", Application.fetch_env!(:loginradius, :apikey)},
    {"apisecret", Application.fetch_env!(:loginradius, :apisecret)}
  ]

  @spec post_request(String.t(), map(), list()) :: LoginRadius.lr_response()
  defp post_request(resource, data, params \\ []) do
    LoginRadius.post_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params ++ params
    )
  end

  @spec get_request(String.t(), list()) :: LoginRadius.lr_response()
  defp get_request(resource, params \\ []) do
    LoginRadius.get_request(
      resource,
      "api",
      @default_headers,
      @default_params ++ params
    ) 
  end

  @spec delete_request(String.t(), map(), list()) :: LoginRadius.lr_response()
  defp delete_request(resource, data, params \\ []) do
    LoginRadius.delete_request(
      resource,
      "api",
      data,
      @default_headers,
      @default_params ++ params
    )
  end

  @doc """
  POST - WebHook Subscribe:
  Subscribes a Webhook on your LoginRadius site.
  https://docs.loginradius.com/api/v2/integrations/web-hook-subscribe-api
  """
  @spec subscribe(map()) :: LoginRadius.lr_response()
  def subscribe(data) do
    @base_resource
      |> post_request(data)
  end

  @doc """
  GET - WebHook Test:
  Tests subscribed Webhooks.
  https://docs.loginradius.com/api/v2/integrations/web-hook-test
  """
  @spec test() :: LoginRadius.lr_response()
  def test() do
    @base_resource <> "/test"
      |> get_request()
  end

  @doc """
  GET - WebHook Subscribed URLs:
  Retrieves all subscribed URLs for a particular event.
  https://docs.loginradius.com/api/v2/integrations/web-hook-subscribed-urls
  """
  @spec get_subscribed_urls(String.t()) :: LoginRadius.lr_response()
  def get_subscribed_urls(event) do
    query_params = [
      {"event", event}
    ]

    @base_resource
      |> get_request(query_params)
  end

  @doc """
  DELETE - WebHook Unsubscribe:
  Unsubscribes a Webhook configured on your LoginRadius site.
  https://docs.loginradius.com/api/v2/integrations/web-hook-unsubscribe
  """
  @spec unsubscribe(map()) :: LoginRadius.lr_response()
  def unsubscribe(data) do
    @base_resource
      |> delete_request(data)
  end
end
