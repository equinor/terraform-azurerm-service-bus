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
  sku                 = var.sku

  dynamic "identity" {
    for_each = local.identity_type != "" ? [1] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }

  # Network Rule Set
  # Conditionally define the entire network_rule_set block based on SKU
  dynamic "network_rule_set" {
    for_each = var.sku == "Premium" ? [1] : []
    content {
      default_action                = var.network_default_action
      public_network_access_enabled = var.public_network_access_enabled
      trusted_services_allowed      = var.trusted_services_allowed
      ip_rules                      = var.ip_rules

      # Conditionally define multiple network_rules inside the network_rule_set
      dynamic "network_rules" {
        for_each = var.network_rules
        content {
          subnet_id                            = each.value.subnet_id
          ignore_missing_vnet_service_endpoint = each.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }

  tags = var.tags
}

# Servicebus Namespace Authorization Rule
resource "azurerm_servicebus_namespace_authorization_rule" "root" {
  for_each = var.namespace_authorization_rule

  name         = each.value.name
  namespace_id = azurerm_servicebus_namespace.this.id
  listen       = each.value.listen
  send         = each.value.send
  manage       = each.value.manage
}

# Servicebus Queue
resource "azurerm_servicebus_queue" "this" {
  for_each = var.servicebus_queue

  name                 = each.value.name
  namespace_id         = azurerm_servicebus_namespace.this.id
  partitioning_enabled = each.value.partitioning_enabled
}

# Receiver Authorization Rule
resource "azurerm_servicebus_queue_authorization_rule" "listen" {
  name     = "sbq-${var.namespace_name}-listen"
  queue_id = azurerm_servicebus_queue.this.id

  listen = true
  send   = false
  manage = false
}

# Sender Authorization Rule
resource "azurerm_servicebus_queue_authorization_rule" "send" {
  name     = "sbq-${var.namespace_name}-send"
  queue_id = azurerm_servicebus_queue.this.id

  listen = false
  send   = true
  manage = false
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
