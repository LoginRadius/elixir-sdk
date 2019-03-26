defmodule SocialLoginTest do
  use ExUnit.Case

  defp get_access_token(test_login) do
    test_login
    |> elem(1)
    |> elem(1)
    |> Map.fetch!("access_token")
  end

  test "Post Message" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts("Need to specify a Twitter access token and token secret to test Post Message API.")
    else
      test_pm_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.message_post(
          "991413461560131585",
          "The Message",
          "This is a message."
        )

      assert elem(test_pm_response, 0) == :ok
    end
  end

  test "Status Posting POST" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts(
        "Need to specify a Twitter access token and token secret to test Status Posting POST API."
      )
    else
      randno =
        :rand.uniform(1000)
        |> Integer.to_string()

      test_sp_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.status_posting_post(
          "Test Post",
          "www.test.com",
          "www.test.com",
          "This is a test post. -" <> randno,
          "A post.",
          "A post."
        )

      assert elem(test_sp_response, 0) == :ok
    end
  end

  test "Access Token Translate" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts(
        "Need to specify a Twitter access token and token secret to test Access Token Translate API."
      )
    else
      test_att_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.access_token()

      assert elem(test_att_response, 0) == :ok
    end
  end

  test "Access Token Validate" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts(
        "Need to specify a Twitter access token and token secret to test Access Token Validate API."
      )
    else
      test_atv_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.validate_access_token()

      assert elem(test_atv_response, 0) == :ok
    end
  end

  test "Access Token Invalidate" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts(
        "Need to specify a Twitter access token and token secret to test Access Token Invalidate API."
      )
    else
      test_atv_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.invalidate_access_token()

      assert elem(test_atv_response, 0) == :ok
    end
  end

  test "Album" do
    # Using Vkontakte
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Album API.")
    else
      test_album_response =
        LoginRadius.TokenManagement.access_token_via_vkontakte_token(
          LoginRadiusTest.vkontakte_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.album()

      assert elem(test_album_response, 0) == :ok
    end
  end

  test "Audio" do
    # Using Vkontakte
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Audio API.")
    else
      test_audio_response =
        LoginRadius.TokenManagement.access_token_via_vkontakte_token(
          LoginRadiusTest.vkontakte_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.audio()

      assert elem(test_audio_response, 0) == :ok
    end
  end

  test "Check In" do
    # Using Vkontakte
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Check In API.")
    else
      test_ci_response =
        LoginRadius.TokenManagement.access_token_via_vkontakte_token(
          LoginRadiusTest.vkontakte_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.check_in()

      assert elem(test_ci_response, 0) == :ok
    end
  end

  test "Company" do
    # Using Facebook
    if LoginRadiusTest.facebook_access_token() == "" do
      IO.puts("Need to specify a Facebook access token to test Company API.")
    else
      test_company_response =
        LoginRadius.TokenManagement.access_token_via_facebook_token(
          LoginRadiusTest.facebook_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.company()

      assert elem(test_company_response, 0) == :ok
    end
  end

  test "Contact" do
    # Using Vkontakte
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Contact API.")
    else
      test_contact_response =
        LoginRadius.TokenManagement.access_token_via_vkontakte_token(
          LoginRadiusTest.vkontakte_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.contact()

      assert elem(test_contact_response, 0) == :ok
    end
  end

  test "Event" do
    # Using Facebook
    if LoginRadiusTest.facebook_access_token() == "" do
      IO.puts("Need to specify a Facebook access token to test Event API.")
    else
      test_event_response =
        LoginRadius.TokenManagement.access_token_via_facebook_token(
          LoginRadiusTest.facebook_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.event()

      assert elem(test_event_response, 0) == :ok
    end
  end

  test "Following" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts("Need to specify a Twitter access token and token secret to test Following API.")
    else
      test_following_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.following()

      assert elem(test_following_response, 0) == :ok
    end
  end

  test "Group" do
    # Using Vkontakte
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Group API.")
    else
      test_group_response =
        LoginRadius.TokenManagement.access_token_via_vkontakte_token(
          LoginRadiusTest.vkontakte_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.group()

      assert elem(test_group_response, 0) == :ok
    end
  end

  test "Like" do
    # Using Facebook
    if LoginRadiusTest.facebook_access_token() == "" do
      IO.puts("Need to specify a Facebook access token to test Like API.")
    else
      test_like_response =
        LoginRadius.TokenManagement.access_token_via_facebook_token(
          LoginRadiusTest.facebook_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.like()

      assert elem(test_like_response, 0) == :ok
    end
  end

  test "Mention" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts("Need to specify a Twitter access token and token secret to test Mention API.")
    else
      test_mention_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.mention()

      assert elem(test_mention_response, 0) == :ok
    end
  end

  test "Get Message" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts("Need to specify a Twitter access token and token secret to test Get Message API.")
    else
      test_gm_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.message_get(
          "991413461560131585",
          "The Message",
          "This is a message."
        )

      assert elem(test_gm_response, 0) == :ok
    end
  end

  test "Page" do
    # Using Facebook
    if LoginRadiusTest.facebook_access_token() == "" do
      IO.puts("Need to specify a Facebook access token to test Page API.")
    else
      test_page_response =
        LoginRadius.TokenManagement.access_token_via_facebook_token(
          LoginRadiusTest.facebook_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.page("loginradius")

      assert elem(test_page_response, 0) == :ok
    end
  end

  test "Photo" do
    # Using Vkontakte
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Photo API.")
    else
      test_photo_response =
        LoginRadius.TokenManagement.access_token_via_vkontakte_token(
          LoginRadiusTest.vkontakte_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.photo("1")

      assert elem(test_photo_response, 0) == :ok
    end
  end

  test "Post" do
    # Using Facebook
    if LoginRadiusTest.facebook_access_token() == "" do
      IO.puts("Need to specify a Facebook access token to test Post API.")
    else
      test_post_response =
        LoginRadius.TokenManagement.access_token_via_facebook_token(
          LoginRadiusTest.facebook_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.post()

      assert elem(test_post_response, 0) == :ok
    end
  end

  test "Status Fetching" do
    # Using Vkontakte
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Status Fetching API.")
    else
      test_sf_response =
        LoginRadius.TokenManagement.access_token_via_vkontakte_token(
          LoginRadiusTest.vkontakte_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.status_fetching()

      assert elem(test_sf_response, 0) == :ok
    end
  end

  test "Status Posting" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts(
        "Need to specify a Twitter access token and token secret to test Status Posting GET API."
      )
    else
      randno =
        :rand.uniform(1000)
        |> Integer.to_string()

      test_sp_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.status_posting_get(
          "Test Post",
          "www.test.com",
          "www.test.com",
          "This is a test post. -" <> randno,
          "A post.",
          "A post."
        )

      assert elem(test_sp_response, 0) == :ok
    end
  end

  test "User Profile" do
    # Using Twitter
    if LoginRadiusTest.twitter_access_token() == "" &&
         LoginRadiusTest.twitter_token_secret() == "" do
      IO.puts("Need to specify a Twitter access token and token secret to test User Profile API.")
    else
      test_up_response =
        LoginRadius.TokenManagement.access_token_via_twitter_token(
          LoginRadiusTest.twitter_access_token(),
          LoginRadiusTest.twitter_token_secret()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.user_profile()

      assert elem(test_up_response, 0) == :ok
    end
  end

  test "Video" do
    # Using Vkontakte
    if LoginRadiusTest.vkontakte_access_token() == "" do
      IO.puts("Need to specify a Vkontakte access token to test Video API.")
    else
      test_video_response =
        LoginRadius.TokenManagement.access_token_via_vkontakte_token(
          LoginRadiusTest.vkontakte_access_token()
        )
        |> get_access_token()
        |> LoginRadius.SocialLogin.video()

      assert elem(test_video_response, 0) == :ok
    end
  end
end
