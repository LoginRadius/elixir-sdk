defmodule ConfigurationTest do
  use ExUnit.Case

  test "Get Configurations" do
    test_gc_response = LoginRadius.Configuration.get_configurations()
    assert elem(test_gc_response, 0) == :ok
  end
end
