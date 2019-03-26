defmodule CustomObjectManagementTest do
  use ExUnit.Case

  defp get_uid(test_login) do
    test_login
    |> elem(1)
    |> elem(1)
    |> Map.fetch!("Profile")
    |> Map.fetch!("Uid")
  end

  defp get_access_token(test_login) do
    test_login
    |> elem(1)
    |> elem(1)
    |> Map.fetch!("access_token")
  end

  setup_all do
    test_data =
      LoginRadius.Account.create(%{
        "FirstName" => "testaccount",
        "LastName" => "auto",
        "Email" => [
          %{
            "Type" => "Primary",
            "Value" => "testaccountauto@mailinator.com"
          }
        ],
        "UserName" => "taa",
        "State" => "Alberta",
        "City" => "Edmonton",
        "ProfileCity" => "Edmonton",
        "ProfileCountry" => "Canada",
        "Password" => "password",
        "PhoneId" => "17787694512",
        "EmailVerified" => true
      })

    login_data = %{
      "email" => "testaccountauto@mailinator.com",
      "password" => "password"
    }

    test_login = LoginRadius.Authentication.login_by_email(login_data)

    on_exit(fn ->
      elem(test_data, 1)
      |> elem(1)
      |> Map.fetch!("Uid")
      |> LoginRadius.Account.delete()
    end)

    %{"test_login" => test_login}
  end

  test "Custom Object Management Integration Test", %{"test_login" => test_login} do
    test_object_name = LoginRadiusTest.test_custom_object_name()

    if test_object_name == "" do
      IO.puts("Need to specify a custom object name to test Custom Object Management APIs.")
    else
      # Create Custom Object by UID
      custom_data = %{
        "customdata1" => "custom data 1"
      }

      test_ccobu_response =
        test_login
        |> get_uid()
        |> LoginRadius.CustomObjectManagement.create_by_uid(test_object_name, custom_data)

      assert elem(test_ccobu_response, 0) == :ok

      # Create Custom Object by Token
      custom_data2 = %{
        "customdata2" => "custom data 2"
      }

      test_ccobt_response =
        test_login
        |> get_access_token()
        |> LoginRadius.CustomObjectManagement.create_by_access_token(
          test_object_name,
          custom_data2
        )

      assert elem(test_ccobt_response, 0) == :ok

      # Custom Object by ObjectRecordId and UID
      custom_object_id1 =
        test_ccobt_response
        |> elem(1)
        |> elem(1)
        |> Map.fetch!("Id")

      test_cobou_response =
        test_login
        |> get_uid()
        |> LoginRadius.CustomObjectManagement.get_by_objectrecordid_and_uid(
          custom_object_id1,
          test_object_name
        )

      assert elem(test_cobou_response, 0) == :ok

      # Custom Object by ObjectRecordId and Token
      test_cobot_response =
        test_login
        |> get_access_token()
        |> LoginRadius.CustomObjectManagement.get_by_objectrecordid_and_access_token(
          custom_object_id1,
          test_object_name
        )

      assert elem(test_cobot_response, 0) == :ok

      # Custom Object by Token
      test_cot_response =
        test_login
        |> get_access_token()
        |> LoginRadius.CustomObjectManagement.get_by_access_token(test_object_name)

      assert elem(test_cot_response, 0) == :ok

      # Custom Object by UID
      test_cou_response =
        test_login
        |> get_uid()
        |> LoginRadius.CustomObjectManagement.get_by_uid(test_object_name)

      assert elem(test_cou_response, 0) == :ok

      # Custom Object Update by UID
      custom_update_data = %{
        "customdata1" => "custom updated data 1"
      }

      test_couu_response =
        test_login
        |> get_uid()
        |> LoginRadius.CustomObjectManagement.update_by_objectrecordid_and_uid(
          custom_object_id1,
          test_object_name,
          "replace",
          custom_update_data
        )

      assert elem(test_couu_response, 0) == :ok

      # Custom Object Update by Access Token
      custom_update_data2 = %{
        "customdata1" => "custom updated data 2"
      }

      test_couat_response =
        test_login
        |> get_access_token()
        |> LoginRadius.CustomObjectManagement.update_by_objectrecordid_and_access_token(
          custom_object_id1,
          test_object_name,
          "partialreplace",
          custom_update_data2
        )

      assert elem(test_couat_response, 0) == :ok

      # Delete Custom Object by ObjectRecordId
      test_dcoo_response =
        test_login
        |> get_uid()
        |> LoginRadius.CustomObjectManagement.delete_by_objectrecordid_and_uid(
          custom_object_id1,
          test_object_name
        )

      assert elem(test_dcoo_response, 0) == :ok

      # Custom Object Delete by Record Id and Token
      custom_object_id2 =
        test_ccobu_response
        |> elem(1)
        |> elem(1)
        |> Map.fetch!("Id")

      test_codrit_response =
        test_login
        |> get_access_token()
        |> LoginRadius.CustomObjectManagement.delete_by_objectrecordid_and_access_token(
          custom_object_id2,
          test_object_name
        )

      assert elem(test_codrit_response, 0) == :ok
    end
  end
end
