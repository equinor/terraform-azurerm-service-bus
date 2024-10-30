mock_provider "azurerm" {}

run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "basic_sku" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.public_network_access_enabled == false
    error_message = "Invalid public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].public_network_access_enabled == false
    error_message = "Invalid network rule set public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].default_action == "Allow"
    error_message = "Invalid network rule set default action"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].ip_rules) == 0
    error_message = "Invalid number of network rule set IP rules"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].network_rules) == 0
    error_message = "Invalid number of network rule set virtual network rules"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].trusted_services_allowed == true
    error_message = "Invalid network rule set trusted services"
  }
}

run "standard_sku" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sku = "Standard"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.public_network_access_enabled == false
    error_message = "Invalid public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].public_network_access_enabled == false
    error_message = "Invalid network rule set public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].default_action == "Allow"
    error_message = "Invalid network rule set default action"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].ip_rules) == 0
    error_message = "Invalid number of network rule set IP rules"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].network_rules) == 0
    error_message = "Invalid number of network rule set virtual network rules"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].trusted_services_allowed == true
    error_message = "Invalid network rule set trusted services"
  }
}

run "premium_sku" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sku = "Premium"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.public_network_access_enabled == false
    error_message = "Invalid public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].public_network_access_enabled == false
    error_message = "Invalid network rule set public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].default_action == "Allow"
    error_message = "Invalid network rule set default action"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].ip_rules) == 0
    error_message = "Invalid number of network rule set IP rules"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].network_rules) == 0
    error_message = "Invalid number of network rule set virtual network rules"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].trusted_services_allowed == true
    error_message = "Invalid network rule set trusted services"
  }
}

run "public_network_access_enabled" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sku = "Premium"

    public_network_access_enabled = true
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.public_network_access_enabled == true
    error_message = "Invalid public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].public_network_access_enabled == true
    error_message = "Invalid network rule set public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].default_action == "Allow"
    error_message = "Invalid network rule set default action"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].ip_rules) == 0
    error_message = "Invalid number of network rule set IP rules"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].network_rules) == 0
    error_message = "Invalid number of network rule set virtual network rules"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].trusted_services_allowed == true
    error_message = "Invalid network rule set trusted services"
  }
}

run "network_rule_set_ip_rules" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sku = "Premium"

    public_network_access_enabled = true
    network_rule_set_ip_rules     = ["1.1.1.1/32", "2.2.2.2/32", "3.3.3.3/31"]
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.public_network_access_enabled == true
    error_message = "Invalid public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].public_network_access_enabled == true
    error_message = "Invalid network rule set public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].default_action == "Deny"
    error_message = "Invalid network rule set default action"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].ip_rules) == 3
    error_message = "Invalid number of network rule set IP rules"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].network_rules) == 0
    error_message = "Invalid number of network rule set virtual network rules"
  }
}

run "network_rule_set_virtual_network_rules" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sku = "Premium"

    public_network_access_enabled = true
    network_rule_set_virtual_network_rules = [
      {
        subnet_id = run.setup_tests.subnet_ids[0]
      },
      {
        subnet_id = run.setup_tests.subnet_ids[1]
      },
      {
        subnet_id = run.setup_tests.subnet_ids[2]
      }
    ]
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.public_network_access_enabled == true
    error_message = "Invalid public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].public_network_access_enabled == true
    error_message = "Invalid network rule set public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].default_action == "Deny"
    error_message = "Invalid network rule set default action"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].ip_rules) == 0
    error_message = "Invalid number of network rule set IP rules"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].network_rules) == 3
    error_message = "Invalid number of network rule set virtual network rules"
  }
}

run "network_rule_set_trusted_services_allowed" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id

    sku = "Premium"

    network_rule_set_trusted_services_allowed = false
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.public_network_access_enabled == false
    error_message = "Invalid public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].public_network_access_enabled == false
    error_message = "Invalid network rule set public network access"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].default_action == "Allow"
    error_message = "Invalid network rule set default action"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].ip_rules) == 0
    error_message = "Invalid number of network rule set IP rules"
  }

  assert {
    condition     = length(azurerm_servicebus_namespace.this.network_rule_set[0].network_rules) == 0
    error_message = "Invalid number of network rule set virtual network rules"
  }

  assert {
    condition     = azurerm_servicebus_namespace.this.network_rule_set[0].trusted_services_allowed == false
    error_message = "Invalid network rule set trusted services"
  }
}
