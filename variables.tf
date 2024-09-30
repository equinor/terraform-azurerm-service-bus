variable "namespace_name" {
  description = "The name of the Servicebus Namespace"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
}

variable "sku" {
  description = "Defines which SKU to use. Options are Basic, Standard or Premium."
  type        = string
  default     = "Basic"
}

variable "local_auth_enabled" {
  description = "Should local authentication using shared access signatures (SAS) be enabled for this Service Bus namespace? If value is false, Microsoft Entra authentication must be used instead."
  type        = bool
  default     = false
}

variable "capacity" {
  description = "Specifies the capacity. Premium allows 1, 2, 4, 8 or 16. Basic or Standard allows 0 only."
  type        = number
  default     = 1
  nullable    = false
}

variable "premium_messaging_partitions" {
  description = "Only valid when sku is Premium and the minimum number is 1. Possible values include 0, 1, 2, and 4. Defaults to 0"
  type        = number
  default     = 1
  nullable    = false
}

variable "public_network_access_enabled" {
  description = "Is public network access enabled for the Service Bus Namespace?"
  type        = bool
  default     = true
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Service Bus namespace?"
  type        = bool
  default     = false
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Service Bus namespace."
  type        = list(string)
  default     = []
}

variable "network_rule_set_ip_rules" {
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the ServiceBus Namespace."
  type        = list(string)
  default     = []
}

variable "network_rule_set_virtual_network_rules" {
  description = "Conditionally define multiple network_rules inside the network_rule_set"

  type = list(object({
    subnet_id                            = string
    ignore_missing_vnet_service_endpoint = optional(bool, false)
  }))

  default = []
}

variable "network_rule_set_trusted_services_allowed" {
  description = "Azure Services that are known and trusted for this resource type are allowed to bypass firewall configuration"
  type        = bool
  default     = true
}

variable "namespace_authorization_rule" {
  description = "Manages a ServiceBus Namespace authorization Rule within a ServiceBus."
  type = map(object({
    name   = string
    listen = bool
    send   = bool
    manage = bool
  }))
  default = {}
}

variable "queue" {
  description = "Manages a ServiceBus Queue."
  type = map(object({
    name                 = string
    partitioning_enabled = optional(bool, false)
  }))
  default = {}
}

variable "topic" {
  description = "Manages a ServiceBus Topic."
  type = map(object({
    name                 = string
    partitioning_enabled = optional(bool, false)
  }))
  default = {}

}

variable "queue_authorization_rule" {
  description = "Manages an Authorization Rule for a ServiceBus Queue."
  type = map(object({
    name       = string
    queue_name = string
    listen     = bool
    send       = bool
    manage     = bool
  }))
  default = {}
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)

  default = [
    "OperationalLogs",
    "VNetAndIPFilteringLogs" # Costless ServiceBus Namespace categories
  ]
}

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of metric categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = []
}

variable "diagnostic_setting_name" {
  description = "The name of this Diagnostic Setting."
  type        = string
  default     = "audit-logs"
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
