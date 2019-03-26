defmodule LoginRadius.SocialLogin do
  @moduledoc """
  Elixir wrapper for the LoginRadius Social Login API module
  """
  
  @apikey Application.fetch_env!(:loginradius, :apikey)
  @apisecret Application.fetch_env!(:loginradius, :apisecret)

  @base_resource "/api/v2"
  # Social Login APIs don't support API secrets in headers.

  @spec post_request(String.t(), map(), list(), list()) :: LoginRadius.lr_response()
  defp post_request(resource, data, headers, params) do
    LoginRadius.post_request(
      resource,
      "api",
      data,
      headers,
      params
    )
  end

  @spec get_request(String.t(), list(), list()) :: LoginRadius.lr_response()
  defp get_request(resource, headers, params) do
    LoginRadius.get_request(
      resource,
      "api",
      headers,
      params
    )
  end

  @doc """
  POST - Post Message API:
  Posts messages to a user's contacts. This is part of the Friend Invite System.
  Used after the Contact API, and requires setting of permissions in LR Dashboard.
  (Twitter, LinkedIn)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/post-message-api
  """
  @spec message_post(String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def message_post(access_token, to, subject, message) do
    query_params = [
      {"access_token", access_token},
      {"to", to},
      {"subject", subject},
      {"message", message}
    ]

    @base_resource <> "/message"
      |> post_request(%{}, [], query_params)
  end

  @doc """
  POST - Status Posting POST:
  Updates the status on a user's wall.
  (Facebook, Twitter, LinkedIn)
  https://docs.loginradius.com/api/v2/social-login/post-status-posting
  """
  @spec status_posting_post(String.t(), String.t(), String.t(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def status_posting_post(access_token, title, url, image_url, status, caption, description) do
    query_params = [
      {"access_token", access_token},
      {"title", title},
      {"url", url},
      {"imageurl", image_url},
      {"status", status},
      {"caption", caption},
      {"description", description}
    ]

    @base_resource <> "/status"
      |> post_request(%{}, [], query_params)
  end

  @doc """
  GET - Access Token:
  Translates the request token returned during social provider authentication into an access token
  that can be used with LR API calls.
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/access-token
  """
  @spec access_token(String.t()) :: LoginRadius.lr_response()
  def access_token(request_token) do
    query_params = [
      {"token", request_token},
      {"secret", @apisecret}
    ]

    @base_resource <> "/access_token"
      |> get_request([], query_params)
  end

  @doc """
  GET - Validate Access Token:
  Validates an access token, returns error if invalid.
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/validate-access-token
  """
  @spec validate_access_token(String.t()) :: LoginRadius.lr_response()
  def validate_access_token(access_token) do
    query_params = [
      {"access_token", access_token},
      {"key", @apikey},
      {"secret", @apisecret}
    ]

    @base_resource <> "/access_token/validate"
      |> get_request([], query_params)
  end

  @doc """
  GET - Invalidate Access Token:
  Invalidates an active access token.
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/invalidate-access-token
  """
  @spec invalidate_access_token(String.t()) :: LoginRadius.lr_response()
  def invalidate_access_token(access_token) do
    query_params = [
      {"access_token", access_token},
      {"key", @apikey},
      {"secret", @apisecret}
    ]

    @base_resource <> "/access_token/invalidate"
      |> get_request([], query_params)
  end

  @doc """
  GET - Album:
  Retrieves the photo albums associated with an access token.
  (Facebook, Google, Live, Vkontakte)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/album
  """
  @spec album(String.t()) :: LoginRadius.lr_response()
  def album(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/album"
      |> get_request([], query_params)
  end

  @doc """
  GET - Audio:
  Retrieves the audio files associated with an access token.
  (Live, Vkontakte)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/audio
  """
  @spec audio(String.t()) :: LoginRadius.lr_response()
  def audio(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/audio"
      |> get_request([], query_params)
  end

  @doc """
  GET - Check In:
  Retrieves the check in data associated with an access token.
  (Facebook, Foursquare, Vkontakte) 
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/check-in
  """
  @spec check_in(String.t()) :: LoginRadius.lr_response()
  def check_in(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/checkin"
      |> get_request([], query_params)
  end

  @doc """
  GET - Company:
  Retrieves a user's followed companies data associated with an access token.
  (Facebook, LinkedIn)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/company
  """
  @spec company(String.t()) :: LoginRadius.lr_response()
  def company(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/company"
      |> get_request([], query_params)
  end

  @doc """
  GET - Contact:
  Retrieves the contacts/friends/connections data associated with an access token. This is part of the
  LR Friend Invite System, and requires permissions to be set in the LR Dashboard.
  (Facebook, Foursquare, Google, LinkedIn, Live, Twitter, Vkontakte, Yahoo)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/contact
  """
  @spec contact(String.t(), String.t()) :: LoginRadius.lr_response()
  def contact(access_token, next_cursor \\ "") do
    query_params = [
      {"access_token", access_token},
      {"nextcursor", next_cursor}
    ]

    @base_resource <> "/contact"
      |> get_request([], query_params)
  end

  @doc """
  GET - Event:
  Retrieves Event data associated with an access token.
  (Facebook, Live)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/event
  """
  @spec event(String.t()) :: LoginRadius.lr_response()
  def event(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/event"
      |> get_request([], query_params)
  end

  @doc """
  GET - Following:
  Retrieves Following user list associated with an access token.
  (Twitter)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/following
  """
  @spec following(String.t()) :: LoginRadius.lr_response()
  def following(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/following"
      |> get_request([], query_params)
  end

  @doc """
  GET - Group:
  Retrieves Group data associated with an access token.
  (Facebook, Vkontakte)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/group
  """
  @spec group(String.t()) :: LoginRadius.lr_response()
  def group(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/group"
      |> get_request([], query_params)
  end

  @doc """
  GET - Like:
  Retrieves Like data associated with an access token.
  (Facebook)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/like
  """
  @spec like(String.t()) :: LoginRadius.lr_response()
  def like(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/like"
      |> get_request([], query_params)
  end

  @doc """
  GET - Mention:
  Retrieves Mentions data associated with an access token.
  (Twitter)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/mention
  """
  @spec mention(String.t()) :: LoginRadius.lr_response()
  def mention(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/mention"
      |> get_request([], query_params)
  end

  @doc """
  GET - Get Message API:
  Posts messages to a user's contacts. This is part of the Friend Invite System.
  Used after the Contact API, and requires setting of permissions in LR Dashboard.
  Identical to message_post.
  (Twitter, LinkedIn)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/get-message-api
  """
  @spec message_get(String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def message_get(access_token, to, subject, message) do
    query_params = [
      {"access_token", access_token},
      {"to", to},
      {"subject", subject},
      {"message", message}
    ]

    @base_resource <> "/message/js"
      |> get_request([], query_params)
  end

  @doc """
  GET - Page:
  Retrieves page data associated with an access token.
  (Facebook, LinkedIn)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/page
  """
  @spec page(String.t(), String.t()) :: LoginRadius.lr_response()
  def page(access_token, page_name) do
    query_params = [
      {"access_token", access_token},
      {"pagename", page_name}
    ]

    @base_resource <> "/page"
      |> get_request([], query_params)
  end

  @doc """
  GET - Photo:
  Retrieves photo data associated with an access token.
  (Facebook, Foursquare, Google, Live, Vkontakte)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/photo
  """
  @spec photo(String.t(), String.t()) :: LoginRadius.lr_response()
  def photo(access_token, album_id) do
    query_params = [
      {"access_token", access_token},
      {"albumid", album_id}
    ]

    @base_resource <> "/photo"
      |> get_request([], query_params)
  end

  @doc """
  GET - Post:
  Retrieves post message data associated with an access token.
  (Facebook)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/post
  """
  @spec post(String.t()) :: LoginRadius.lr_response()
  def post(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/post"
      |> get_request([], query_params)
  end

  @doc """
  GET - Status Fetching:
  Retrieves status messages associated with an access token.
  (Facebook, Linkedin, Twitter, Vkontakte)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/status-fetching
  """
  @spec status_fetching(String.t()) :: LoginRadius.lr_response()
  def status_fetching(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/status"
      |> get_request([], query_params)
  end

  @doc """
  GET - Status Posting:
  Updates the status on a user (associated with an access token)'s wall.
  Identical to status_posting_post.
  (Facebook, Twitter, LinkedIn)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/status-posting
  """
  @spec status_posting_get(String.t(), String.t(), String.t(), String.t(), String.t(), String.t(), String.t()) :: LoginRadius.lr_response()
  def status_posting_get(access_token, title, url, image_url, status, caption, description) do
    query_params = [
      {"access_token", access_token},
      {"title", title},
      {"url", url},
      {"imageurl", image_url},
      {"status", status},
      {"caption", caption},
      {"description", description}
    ]

    @base_resource <> "/status/js"
      |> get_request([], query_params)
  end

  @doc """
  GET - User Profile:
  Retrieves social profile data associated with an access token.
  (All)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/user-profile
  """
  @spec user_profile(String.t()) :: LoginRadius.lr_response()
  def user_profile(access_token) do
    query_params = [
      {"access_token", access_token}
    ]

    @base_resource <> "/userprofile"
      |> get_request([], query_params)
  end

  @doc """
  GET - Video:
  Retrieves video files data associated with an access token.
  (Facebook, Google, Live, Vkontakte)
  https://docs.loginradius.com/api/v2/customer-identity-api/social-login/advanced-social-api/video
  """
  @spec video(String.t()) :: LoginRadius.lr_response()
  def video(access_token, next_cursor \\ "") do
    query_params = [
      {"access_token", access_token},
      {"nextcursor", next_cursor}
    ]

    @base_resource <> "/video"
      |> get_request([], query_params)
  end
end
