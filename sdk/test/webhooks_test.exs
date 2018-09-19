defmodule WebhooksTest do
  use ExUnit.Case

  # Execution Order
  # Webhook Subscribe
  # Webhook Test
  # Webhook Subscribed URLs
  # Webhook Unsubscribe
  test "Webhooks Integration Test" do
    # Webhook Subscribe
    subscribe_data = %{
      "targeturl" => "https://www.test.com",
      "event" => "Login"
    }

    test_whs_response = subscribe_data
      |> LoginRadius.Webhooks.subscribe()

    assert elem(test_whs_response, 0) == :ok

    # Webhook Test
    test_wht_response = LoginRadius.Webhooks.test()
    
    assert elem(test_wht_response, 0) == :ok

    # Webhook Subscribed URLs
    test_whsu_response = LoginRadius.Webhooks.get_subscribed_urls("Login")

    assert elem(test_whsu_response, 0) == :ok

    # Webhook Unsubscribe
    test_whu_response = subscribe_data
      |> LoginRadius.Webhooks.unsubscribe()

    assert elem(test_whu_response, 0) == :ok
  end
end
