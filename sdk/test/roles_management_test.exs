defmodule RolesManagementTest do
  use ExUnit.Case

  @doc """
  Integration Test method call order
  Create User
  Create Role (2)
  Get Roles List
  Get Roles by UID
  Account Add Permissions to Role
  Roles Assign to User
  Upsert Context
  Get Context with Roles and Permissions
  Delete Additional Permissions from context
  Delete role from context
  Delete Context
  Unassign Roles by UID
  Remove Permissions from role
  Delete Role
  Delete User
  """
  test "Roles Management Integration Test" do
    # Create User
    test_account_uid = LoginRadius.Account.create(
      %{
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
        "PhoneId" => "17787694512"
      })
      |> elem(1)
      |> elem(1)
      |> Map.fetch!("Uid")

    # Create 2 roles
    role_data = %{
      "roles" => [
        %{
          "name" => "example_role",
          "permissions" => %{
            "pname1" => true,
            "pname2" => true
          }
        },
        %{
          "name" => "example_role2",
          "permissions" => %{
            "pname3" => true,
            "pname4" => true
          }
        }
      ]
    }
    test_rc_response = LoginRadius.RolesManagement.roles_create(role_data)

    assert elem(test_rc_response, 0) == :ok

    # Get list of roles
    test_rl_response = LoginRadius.RolesManagement.roles_list()

    assert elem(test_rl_response, 0) == :ok

    # Add permissions to role
    permission_data = %{
      "permissions" => [
        "pname5",
        "pname6"
      ]
    }
    test_aaptr_response = "example_role2"
      |> LoginRadius.RolesManagement.add_permissions_to_role(permission_data)

    assert elem(test_aaptr_response, 0) == :ok

    # Assign role to user
    assign_data = %{
      "roles" => [
        "example_role",
        "example_role2"
      ]
    }
    test_ratu_response = test_account_uid
      |> LoginRadius.RolesManagement.assign_roles_by_uid(assign_data)
    
    assert elem(test_ratu_response, 0) == :ok

    # Get roles by UID
    test_rbu_response = test_account_uid
      |> LoginRadius.RolesManagement.roles_by_uid()

    assert elem(test_rbu_response, 0) == :ok

    # Upsert context
    context_data = %{
      "rolecontext" => [
        %{
          "context" => "example_context",
          "roles" => [
            "example_role",
            "example_role2"
          ],
          "additionalpermissions" => [
            "eap1",
            "eap2"
          ],
          "expiration" => "2018-10-01 8:30:00 AM"
        }
      ]
    }
    test_uc_response = test_account_uid
      |> LoginRadius.RolesManagement.upsert_context(context_data)

    assert elem(test_uc_response, 0) == :ok

    # Get Context
    test_gcwrap_response = test_account_uid
      |> LoginRadius.RolesManagement.get_contexts()

    assert elem(test_gcwrap_response, 0) == :ok

    # Delete additional permissions from context
    delete_additional_permissions_data = %{
      "additionalpermissions" => [
        "eap1",
        "eap2"
      ]
    }
    test_dapfc_response = test_account_uid
      |> LoginRadius.RolesManagement.delete_additional_permissions_from_context("example_context", delete_additional_permissions_data)

    assert elem(test_dapfc_response, 0) == :ok

    # Delete role from context
    delete_context_data = %{
      "roles" => [
        "example_role2"
      ]
    }
    test_drfc_response = test_account_uid
      |> LoginRadius.RolesManagement.delete_role_from_context("example_context", delete_context_data)

    assert elem(test_drfc_response, 0) == :ok

    # Delete context
    test_drc_response = test_account_uid
      |> LoginRadius.RolesManagement.delete_role_context("example_context")
    
    assert elem(test_drc_response, 0) == :ok

    # Unassign roles
    unassign_data = %{
      "roles" => [
        "example_role2"
      ]
    }
    test_urbu_response = test_account_uid
      |> LoginRadius.RolesManagement.unassign_roles_by_uid(unassign_data)

    assert elem(test_urbu_response, 0) == :ok

    # Delete permissions from role
    delete_permission_data = %{
      "permissions" => [
        "pname2"
      ]
    }
    test_dpfr_response = "example_role"
      |> LoginRadius.RolesManagement.remove_permissions(delete_permission_data)
    
    assert elem(test_dpfr_response, 0) == :ok

    # Delete Role
    test_dr_response1 = "example_role"
      |> LoginRadius.RolesManagement.delete_role()
    test_dr_response2 = "example_role2"
      |> LoginRadius.RolesManagement.delete_role()

    assert elem(test_dr_response1, 0) == :ok
    assert elem(test_dr_response2, 0) == :ok

    # Delete User
    test_account_uid
      |> LoginRadius.Account.delete()
  end
end
