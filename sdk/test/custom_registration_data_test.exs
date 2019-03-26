defmodule CustomRegistrationDataTest do
  use ExUnit.Case

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

    on_exit(fn ->
      elem(test_data, 1)
      |> elem(1)
      |> Map.fetch!("Uid")
      |> LoginRadius.Account.delete()
    end)
  end

  test "Custom Registration Data Integration Test" do
    # Add Registration Data
    test_custom_registration_data_type = LoginRadiusTest.test_custom_registration_data_type()

    if test_custom_registration_data_type == "" do
      IO.puts(
        "Need to specify a custom registration data type to test Custom Registration Data APIs."
      )
    else
      registration_data = %{
        "Data" => [
          %{
            "type" => test_custom_registration_data_type,
            "key" => "example1",
            "value" => "value1",
            "parentid" => "",
            "code" => "examplecode",
            "isactive" => true
          }
        ]
      }

      test_ard_response =
        registration_data
        |> LoginRadius.CustomRegistrationData.add_registration_data()

      assert elem(test_ard_response, 0) == :ok

      # Get Registration Data
      test_grd_response =
        test_custom_registration_data_type
        |> LoginRadius.CustomRegistrationData.get_registration_data("", "0", "50")

      assert elem(test_grd_response, 0) == :ok

      # Auth Get Registration Data
      test_agrd_response =
        test_custom_registration_data_type
        |> LoginRadius.CustomRegistrationData.auth_get_registration_data("", "0", "50")

      assert elem(test_agrd_response, 0) == :ok

      rd_record_id =
        test_grd_response
        |> elem(1)
        |> elem(1)
        |> List.last()
        |> Map.fetch!("Id")

      rd_code =
        test_grd_response
        |> elem(1)
        |> elem(1)
        |> List.last()
        |> Map.fetch!("Code")

      # Validate Code
      validate_data = %{
        "recordid" => rd_record_id,
        "code" => rd_code
      }

      test_vc_response =
        validate_data
        |> LoginRadius.CustomRegistrationData.validate_code()

      assert elem(test_vc_response, 0) == :ok

      # Update Registration Data
      update_data = %{
        "IsActive" => true,
        "Type" => test_custom_registration_data_type,
        "Key" => "Key",
        "Value" => "A value",
        "ParentId" => "",
        "Code" => rd_code
      }

      test_urd_response =
        rd_record_id
        |> LoginRadius.CustomRegistrationData.update_registration_data(update_data)

      assert elem(test_urd_response, 0) == :ok

      # Delete Registration Data
      test_drd_response =
        rd_record_id
        |> LoginRadius.CustomRegistrationData.delete_registration_data()

      assert elem(test_drd_response, 0) == :ok
    end
  end
end
