variable "namespace_name" {
  description = "The name of this Service Bus namespace."
  type        = string
  nullable    = false
}

variable "resource_group_name" {
  description = "The name of the resource group to create the resources in."
  type        = string
  nullable    = false
}

variable "location" {
  description = "The location to create the resources in."
  type        = string
  nullable    = false
}

variable "sku" {
  description = "The SKU to use for this Service Bus namespace. Value must be \"Basic\", \"Standard\" or \"Premium\"."
  type        = string
  default     = "Basic"
  nullable    = false
}

variable "local_auth_enabled" {
  description = "Should local authentication using shared access signatures (SAS) be enabled for this Service Bus namespace? If value is false, Microsoft Entra authentication must be used instead."
  type        = bool
  default     = false
  nullable    = false
}

variable "capacity" {
  description = "Specifies the capacity for this Service Bus namespace. Value must be 1, 2, 4, 8 or 16. Only applicable if value of sku is \"Premium\"."
  type        = number
  default     = 1
  nullable    = false

  validation {
    condition     = contains([1, 2, 4, 8, 16], var.capacity)
    error_message = "Capacity must be 1, 2, 4, 8 or 16."
  }
}

variable "premium_messaging_partitions" {
  description = "Specifies the number of messaging partitions for this Service Bus namespace. Value must be 1, 2 or 4. Only applicable if value of sku is \"Premium\"."
  type        = number
  default     = 1
  nullable    = false

  validation {
    condition     = contains([1, 2, 4], var.premium_messaging_partitions)
    error_message = "Premium messaging partitions must be 1, 2 or 4."
  }
}

variable "system_assigned_identity_enabled" {
  description = "Should the system-assigned identity be enabled for this Service Bus namespace?"
  type        = bool
  default     = false
  nullable    = false
}

variable "identity_ids" {
  description = "A list of IDs of managed identities to be assigned to this Service Bus namespace."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "network_rule_set_ip_rules" {
  description = "A list of public IP addresses or ranges that should be able to bypass the network rule set for this Service Bus namespace. Values must be in CIDR format. Only applicable if value of sku is \"Premium\"."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "network_rule_set_virtual_network_rules" {
  description = "A list of virtual network subnets that should be able to bypass the network rule set for this Service Bus namespace. Only applicable if value of sku is \"Premium\"."

  type = list(object({
    subnet_id                            = string
    ignore_missing_vnet_service_endpoint = optional(bool, false)
  }))

  default  = []
  nullable = false
}

variable "network_rule_set_trusted_services_allowed" {
  description = "Should Azure services be allowed to bypass the network rule set for this Service Bus namespace? Only applicable if value of sku is \"Premium\"."
  type        = bool
  default     = true
  nullable    = false
}

variable "log_analytics_workspace_id" {
  description = "The ID of the Log Analytics workspace to send diagnostics to."
  type        = string
  nullable    = false
}

variable "diagnostic_setting_enabled_log_categories" {
  description = "A list of log categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = ["RuntimeAuditLogs"]
}

variable "diagnostic_setting_enabled_metric_categories" {
  description = "A list of metric categories to be enabled for this diagnostic setting."
  type        = list(string)
  default     = []
  nullable    = false
}

variable "diagnostic_setting_name" {
  description = "The name of this diagnostic setting."
  type        = string
  default     = "audit-logs"
  nullable    = false
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
  nullable    = false
}
