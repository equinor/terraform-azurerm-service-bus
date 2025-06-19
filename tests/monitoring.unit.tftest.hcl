mock_provider "azurerm" {
  # Override values that are not known until after the plan is applied.
  override_during = plan

  override_resource {
    target = azurerm_servicebus_namespace.this
    values = {
      id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example-resources/providers/Microsoft.ServiceBus/namespaces/example-namespace"
    }
  }

  override_resource {
    target = azurerm_monitor_diagnostic_setting.this
    values = {
      log_analytics_destination_type = null
    }
  }
}

run "setup_tests" {
  module {
    source = "./tests/setup"
  }
}

run "monitoring_defaults" {
  command = plan

  variables {
    namespace_name             = run.setup_tests.namespace_name
    resource_group_name        = run.setup_tests.resource_group_name
    location                   = run.setup_tests.location
    log_analytics_workspace_id = run.setup_tests.log_analytics_workspace_id
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.this.name == "audit-logs"
    error_message = "Diagnostic setting name should be \"audit-logs\" by default"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.this.target_resource_id == azurerm_servicebus_namespace.this.id
    error_message = "Diagnostic setting should be linked to the Service Bus namespace resource resource"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.this.log_analytics_workspace_id == run.setup_tests.log_analytics_workspace_id
    error_message = "Diagnostic setting should be linked to the setup test Log Analytics workspace"
  }

  assert {
    condition     = azurerm_monitor_diagnostic_setting.this.log_analytics_destination_type == null
    error_message = "Diagnostic setting should not have a Log Analytics destination type configured for Service Bus namespace resource"
  }

  assert {
    condition     = length(azurerm_monitor_diagnostic_setting.this.enabled_log) == 1 && tolist(azurerm_monitor_diagnostic_setting.this.enabled_log)[0].category == "RuntimeAuditLogs"
    error_message = "Diagnostic setting should have \"AuditEvent\" log category enabled by default"
  }

  assert {
    condition     = length(azurerm_monitor_diagnostic_setting.this.enabled_metric) == 0
    error_message = "Diagnostic setting should not have any enabled metric categories by default"
  }
}
