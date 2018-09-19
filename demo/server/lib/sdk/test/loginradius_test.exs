defmodule LoginRadiusTest do
  use ExUnit.Case

  # Paste Social Provider Tokens here for use in testing
  @social_login_request_token ""
  @facebook_access_token ""
  @twitter_access_token ""
  @twitter_token_secret ""
  @vkontakte_access_token ""
  @linkedin_access_token ""
  @google_access_token ""

  # Paste Custom Object Name here for use in testing
  @test_custom_object_name ""

  def social_login_request_token, do: @social_login_request_token
  def facebook_access_token, do: @facebook_access_token
  def twitter_access_token, do: @twitter_access_token
  def twitter_token_secret, do: @twitter_token_secret
  def vkontakte_access_token, do: @vkontakte_access_token
  def linkedin_access_token, do: @linkedin_access_token
  def google_access_token, do: @google_access_token

  def test_custom_object_name, do: @test_custom_object_name
end
