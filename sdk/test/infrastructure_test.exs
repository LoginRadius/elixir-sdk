defmodule InfrastructureTest do
  use ExUnit.Case

  test "Generate SOTT" do
    test_sott_response = LoginRadius.Infrastructure.generate_sott()
    assert elem(test_sott_response, 0) == :ok
  end

  test "Generate SOTT 2" do
    test_sott_response = LoginRadius.Infrastructure.generate_sott(60)
    assert elem(test_sott_response, 0) == :ok
  end

  test "Get Server Time" do
    test_gst_response = LoginRadius.Infrastructure.get_server_time(60)
    assert elem(test_gst_response, 0) == :ok
  end

  test "Generate PBKDF2 Key 1" do
    test_key = LoginRadius.Infrastructure.pbkdf2(:sha, "password", <<0, 0, 0, 0, 0, 0, 0, 0>>, 1000, 32)
      |> Base.encode64()
    assert test_key == "x+1lU2MEHchov3OrO0rGhpqx/2dR3V10iI2xUsR0x28="
  end

  test "Generate PBKDF2 Key 2" do
    test_key = LoginRadius.Infrastructure.pbkdf2(:sha256, "example", <<0, 32, 0, 0, 255, 0, 0, 0>>, 500, 16)
      |> Base.encode64()
    assert test_key == "TdrWWsRMpp2oxujMLZ7d9w=="
  end

  test "Generate PBKDF2 Key 3" do
    test_key = LoginRadius.Infrastructure.pbkdf2(:sha512, "example", <<1, 1, 0, 0, 1, 0, 0, 0>>, 750, 64)
      |> Base.encode64()
    assert test_key == "attlny3NNNXNVDB15iSN803VMjyWgTngsEX+TrKrm+v3SB3RTw0UPkxer43lqDDgMX/8SUXPd654zP+ctmiQ0Q=="
  end

  test "Generate Local SOTT" do
    # SOTT Token with given plain_text should be:
    # xU8porvSNArfLvrn4CqyQpDxOkmk5Tljesl0H%2BnHhkqo4Vu1T2CSvpFKBUOmYN9gJJ8ab%2BgTvBt9YtLNG1%2BRKqOseaeyNFh3%2BCGeBFsEa/s=*f15789db4f0ba5335a229d4b504fade6
    # plain_text = "2018/6/22 21:22:16#09200ed0-2b98-49ff-bc9d-6753cbfc42a5#2018/6/22 21:32:16"
    IO.puts("Local SOTT generation tested manually.")
  end
end
