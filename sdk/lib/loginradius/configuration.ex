defmodule LoginRadius.Configuration do
  @moduledoc """
  Elixir wrapper for the LoginRadius Configuration API module
  """

  @apikey Application.fetch_env!(:loginradius_elixir_sdk, :apikey)

  @doc """
  GET - Get Configurations:
  Gets set configurations from the LoginRadius Dashboard for a particular site from apikey.
  https://docs.loginradius.com/api/v2/cloud-api/get-configuration
  """
  @spec get_configurations() :: LoginRadius.response()
  def get_configurations() do
    query_params = [
      {"apikey", @apikey}
    ]
    
    LoginRadius.get!(
        "https://config.lrcontent.com/ciam/appinfo",
        [],
        params: query_params)
      |> LoginRadius.handle_response()
  end
end
