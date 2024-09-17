locals {

  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(var.identity_ids) > 0 ? "UserAssigned" : ""]))

  diagnostic_setting_metric_categories = ["AllMetrics"]
}

resource "azurerm_servicebus_namespace" "this" {
  name                          = var.namespace_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  capacity                      = var.capacity
  premium_messaging_partitions  = var.premium_messaging_partitions
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "identity" {
    for_each = local.identity_type != "" ? [1] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }

  # Network Rule Set
  dynamic "network_rule_set" {
    # Conditionally define the entire network_rule_set block based on SKU
    for_each = var.sku == "Premium" && var.enable_network_rule_set ? [1] : []
    content {
      default_action                = var.network_default_action
      public_network_access_enabled = var.network_public_network_access_enabled
      trusted_services_allowed      = var.trusted_services_allowed
      ip_rules                      = var.ip_rules

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

  tags = var.tags
}

# Servicebus Namespace Authorization Rule
resource "azurerm_servicebus_namespace_authorization_rule" "this" {
  for_each = var.namespace_authorization_rule

  name         = each.value.name
  namespace_id = azurerm_servicebus_namespace.this.id
  listen       = each.value.listen
  send         = each.value.send
  manage       = each.value.manage
}

# Servicebus Queue
resource "azurerm_servicebus_queue" "this" {
  for_each = var.queue

  name                 = each.value.name
  namespace_id         = azurerm_servicebus_namespace.this.id
  partitioning_enabled = each.value.partitioning_enabled
}

# Queue Authorization Rule
resource "azurerm_servicebus_queue_authorization_rule" "this" {
  depends_on = [azurerm_servicebus_queue.this]
  # depends_on = ["${azurerm_servicebus_queue.this}[${each.value.queue_name}]"]
  for_each = var.queue_authorization_rule

  name     = each.value.name
  queue_id = "${azurerm_servicebus_namespace.this.id}/queues/${each.value.queue_name}"
  listen   = each.value.listen
  send     = each.value.send
  manage   = each.value.manage
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
