defmodule LoginRadius.Infrastructure do
  @moduledoc """
  Elixir wrapper for the LoginRadius Infrastructure API module,
  and SOTT generation functions.
  """
  
  @apikey Application.fetch_env!(:loginradius_elixir_sdk, :apikey)
  @apisecret Application.fetch_env!(:loginradius_elixir_sdk, :apisecret)

  @base_resource "/identity/v2"
  @default_params [
    {"apikey", @apikey}
  ]

  @init_vector "tu89geji340t89u2"
  @key_size 256

  @spec get_request(String.t(), list(), list()) :: LoginRadius.response()
  defp get_request(resource, headers, params) do
    LoginRadius.get_request(
      resource,
      headers,
      @default_params ++ params
    )
  end

  @doc """
  GET - Get Server Time:
  Queries for basic server information. Time difference is used to generate values for
  SOTT generation.
  https://docs.loginradius.com/api/v2/user-registration/infrastructure-get-server-time
  """
  @spec get_server_time(integer) :: LoginRadius.handle_response()
  def get_server_time(time_difference \\ 10) do
    query_params = [
      {"timedifference", time_difference}
    ]

    @base_resource <> "/serverinfo"
      |> get_request([], query_params)
  end

  @doc """
  GET - Generate SOTT:
  Generates a Secured One Time Token.
  https://docs.loginradius.com/api/v2/user-registration/generate-sott
  """
  @spec generate_sott(integer) :: LoginRadius.response()
  def generate_sott(validity_length \\ 10) do
    headers = [
      {"X-LoginRadius-ApiSecret", @apisecret}
    ]
    query_params = [
      {"timedifference", validity_length}
    ]

    @base_resource <> "/manage/account/sott"
      |> get_request(headers, query_params)
  end

  @doc """
  Generates a Secured One Time Token locally.
  """
  @spec local_generate_sott(integer()) :: String.t()
  def local_generate_sott(validity_length \\ 10) do
    start_time = DateTime.utc_now
      |> format_datetime()
    end_time = DateTime.utc_now
      |> DateTime.to_unix()
      |> Kernel.+(validity_length * 60)
      |> DateTime.from_unix()
      |> elem(1)
      |> format_datetime()

    plain_text = start_time <> "#" <> @apikey <> "#" <> end_time
    cipher_key = pbkdf2(:sha, @apisecret, <<0, 0, 0, 0, 0, 0, 0, 0>>, 10_000, div(@key_size, 8))
    b64_cipher = :crypto.block_encrypt(:aes_cbc, cipher_key, @init_vector, pkcs7_pad(plain_text, 16))
      |> Base.encode64()

    hash = :crypto.hash(:md5, b64_cipher)
      |> Base.encode16()
      |> String.downcase()

    b64_cipher <> "*" <> hash
  end

  @doc """
  Formats an Elixir DateTime struct into a string following format "YYYY/MM/DD H:i:s"
  """
  @spec format_datetime(DateTime.t()) :: String.t()
  def format_datetime(date) do
    Integer.to_string(date.year) <>
    "/" <>
    Integer.to_string(date.month) <>
    "/" <>
    Integer.to_string(date.day) <>
    " " <>
    Integer.to_string(date.hour) <>
    ":" <>
    Integer.to_string(date.minute) <>
    ":" <>
    Integer.to_string(date.second)
  end

  @doc """
  Appends N bytes with the value of chr(N) where N is the number of bytes required
  to make the final block of data the same size as block size.
  """
  @spec pkcs7_pad(String.t(), integer()) :: String.t()
  def pkcs7_pad(data, block_size) do
    size_difference = block_size - rem(byte_size(data), block_size)
    data <> String.duplicate(List.to_string([size_difference]), size_difference)
  end

  @doc """
  PBKDF2 key derivation function.
  """
  @spec pbkdf2(atom(), String.t(), <<>>, integer(), integer()) :: <<>>
  def pbkdf2(hash_algorithm, password, salt, iterations, length) do
    key = generate_key(hash_algorithm, password, salt, iterations, length, 1)

    <<key::binary-size(length)>>
  end

  defp generate_key(hash_algorithm, password, salt, iterations, max_index, curr_index) when max_index == curr_index do
    xor_hash_iterations(hash_algorithm, password, salt, iterations, iterations, curr_index)
  end
  defp generate_key(hash_algorithm, password, salt, iterations, max_index, curr_index) when max_index > curr_index do
    head = xor_hash_iterations(hash_algorithm, password, salt, iterations, iterations, curr_index)
    tail = generate_key(hash_algorithm, password, salt, iterations, max_index, curr_index + 1)

    head <> tail
  end

  defp xor_hash_iterations(hash_algorithm, password, salt, _, 1, _) do
    :crypto.hmac(hash_algorithm, password, salt)
  end
  defp xor_hash_iterations(hash_algorithm, password, salt, total_iterations, curr_iteration, i) do
    curr =
      if total_iterations == curr_iteration do
        :crypto.hmac(hash_algorithm, password, <<salt::binary, i::integer-size(32)>>)
      else
        :crypto.hmac(hash_algorithm, password, salt)
      end
    next = xor_hash_iterations(hash_algorithm, password, curr, total_iterations, curr_iteration - 1, i)

    curr
      |> :crypto.exor(next)
  end
end
