mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "disable_identity" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.identity) == 0
    error_message = "Invalid number of identity blocks"
  }
}

run "enable_system_assigned_identity" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    system_assigned_identity_enabled = true
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.identity) == 1
    error_message = "Invalid number of identity blocks"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.identity[0].type == "SystemAssigned"
    error_message = "Invalid identity type"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.identity[0].identity_ids) == 0
    error_message = "Invalid identity IDs"
  }
}

run "enable_user_assigned_identity" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    identity_ids = [run.setup_tests.user_assigned_identity_id]
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.identity) == 1
    error_message = "Invalid number of identity blocks"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.identity[0].type == "UserAssigned"
    error_message = "Invalid identity type"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.identity[0].identity_ids) == 1
    error_message = "Invalid identity IDs"
  }
}

run "enable_system_and_user_assigned_identity" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    system_assigned_identity_enabled = true
    identity_ids                     = [run.setup_tests.user_assigned_identity_id]
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.identity) == 1
    error_message = "Invalid number of identity blocks"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.identity[0].type == "SystemAssigned, UserAssigned"
    error_message = "Invalid identity type"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.identity[0].identity_ids) == 1
    error_message = "Invalid identity IDs"
  }
}
