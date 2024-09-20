locals {

  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(var.identity_ids) > 0 ? "UserAssigned" : ""]))

  diagnostic_setting_metric_categories = ["AllMetrics"]
}

resource "azurerm_servicebus_namespace" "this" {
  name                = var.namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                          = var.sku
  capacity                     = var.sku == "Premium" ? var.capacity : 0
  premium_messaging_partitions = var.sku == "Premium" ? var.premium_messaging_partitions : 0

  public_network_access_enabled = var.public_network_access_enabled

  dynamic "network_rule_set" {
    # Conditionally define the entire network_rule_set block based on SKU
    for_each = var.sku == "Premium" ? [1] : []

    content {
      public_network_access_enabled = var.public_network_access_enabled
      default_action                = var.network_rule_set_default_action
      trusted_services_allowed      = var.network_rule_set_trusted_services_allowed
      ip_rules                      = var.network_rule_set_ip_rules

      # Conditionally define multiple network_rules inside the network_rule_set
      dynamic "network_rules" {
        for_each = var.network_rules

        content {
          subnet_id                            = network_rules.value["subnet_id"]
          ignore_missing_vnet_service_endpoint = network_rules.value["ignore_missing_vnet_service_endpoint"]
        }
      }
    }
  }

  dynamic "identity" {
    for_each = local.identity_type != "" ? [1] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  name                       = var.diagnostic_setting_name
  target_resource_id         = azurerm_servicebus_namespace.this.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  # Ref: https://registry.terraform.io/providers/hashicorp/azurerm/3.65.0/docs/resources/monitor_diagnostic_setting#log_analytics_destination_type
  log_analytics_destination_type = null

  dynamic "enabled_log" {
    for_each = toset(var.diagnostic_setting_enabled_log_categories)

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = toset(concat(local.diagnostic_setting_metric_categories, var.diagnostic_setting_enabled_metric_categories))

    content {
      # Azure expects explicit configuration of both enabled and disabled metric categories.
      category = metric.value
      enabled  = contains(var.diagnostic_setting_enabled_metric_categories, metric.value)
    }
  }
}
