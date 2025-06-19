locals {
  # If public network access is not explicitly enabled or disabled, it should be implicitly enabled if one or more IP or virtual network rules are configured.
  # This is because public network access must be enabled for IP and virtual network rules to be configured.
  public_network_access_enabled = coalesce(var.public_network_access_enabled, length(var.network_rule_set_ip_rules) > 0 || length(var.network_rule_set_virtual_network_rules) > 0)

  # If system_assigned_identity_enabled is true, value is "SystemAssigned".
  # If identity_ids is non-empty, value is "UserAssigned".
  # If system_assigned_identity_enabled is true and identity_ids is non-empty, value is "SystemAssigned, UserAssigned".
  identity_type = join(", ", compact([var.system_assigned_identity_enabled ? "SystemAssigned" : "", length(var.identity_ids) > 0 ? "UserAssigned" : ""]))
}

resource "azurerm_servicebus_namespace" "this" {
  name                = var.namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku                          = var.sku
  capacity                     = var.sku == "Premium" ? var.capacity : 0
  premium_messaging_partitions = var.sku == "Premium" ? var.premium_messaging_partitions : 0

  local_auth_enabled            = var.local_auth_enabled
  public_network_access_enabled = local.public_network_access_enabled

  network_rule_set {
    public_network_access_enabled = local.public_network_access_enabled

    # The only allowed value for 'default_action' is "Allow" if no 'ip_rules' or 'network_rules' is set.
    default_action           = length(var.network_rule_set_ip_rules) == 0 && length(var.network_rule_set_virtual_network_rules) == 0 ? "Allow" : "Deny"
    ip_rules                 = var.network_rule_set_ip_rules
    trusted_services_allowed = var.network_rule_set_trusted_services_allowed

    dynamic "network_rules" {
      for_each = var.network_rule_set_virtual_network_rules

      content {
        subnet_id                            = network_rules.value["subnet_id"]
        ignore_missing_vnet_service_endpoint = network_rules.value["ignore_missing_vnet_service_endpoint"]
      }
    }
  }

  dynamic "identity" {
    for_each = local.identity_type != "" ? [0] : []

    content {
      type         = local.identity_type
      identity_ids = var.identity_ids
    }
  }

  tags = var.tags
}

resource "azurerm_servicebus_queue" "this" {
  for_each = var.queues

  name                 = each.value.name
  namespace_id         = azurerm_servicebus_namespace.this.id
  partitioning_enabled = each.value.partitioning_enabled

  lifecycle {
    # Prevent accidental destroy of Service Bus queues
    prevent_destroy = true
  }
}

resource "azurerm_servicebus_topic" "this" {
  for_each = var.topics

  name                 = each.value.name
  namespace_id         = azurerm_servicebus_namespace.this.id
  partitioning_enabled = each.value.partitioning_enabled

  lifecycle {
    # Prevent accidental destroy of Service Bus topics
    prevent_destroy = true
  }
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

  dynamic "enabled_metric" {
    for_each = toset(var.diagnostic_setting_enabled_metric_categories)

    content {
      category = enabled_metric.value
    }
  }
}
