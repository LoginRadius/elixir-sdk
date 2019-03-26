defmodule LoginRadius.Configuration do
  @moduledoc """
  Elixir wrapper for the LoginRadius Configuration API module
  """

  @apikey Application.fetch_env!(:loginradius, :apikey)

  @doc """
  GET - Get Configurations:
  Gets set configurations from the LoginRadius Dashboard for a particular site from apikey.
  https://docs.loginradius.com/api/v2/customer-identity-api/configuration/get-configurations
  """
  @spec get_configurations() :: LoginRadius.lr_response()
  def get_configurations() do
    query_params = [
      {"apikey", @apikey}
    ]
    
    LoginRadius.get_request(
      "/ciam/appinfo",
      "config",
      [],
      query_params
    )
  end
end
