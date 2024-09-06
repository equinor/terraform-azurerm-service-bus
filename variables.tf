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

# network (Private access is only available on Premium namespaces.)
variable "network_default_action" {
  description = "Specifies the default action for the Network Rule Set. Possible values are Allow and Deny."
  type        = string
  default     = "Allow"
}

variable "public_network_access_enabled" {
  description = "Whether to allow traffic over public network. Possible values are true and false."
  type        = bool
  default     = true
}

variable "trusted_services_allowed" {
  description = "Azure Services that are known and trusted for this resource type are allowed to bypass firewall configuration"
  type        = bool
  default     = true
}

variable "ip_rules" {
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the ServiceBus Namespace."
  type        = list(string)
  default     = []
}

variable "network_rules" {
  description = "value"
  type = list(object({
    subnet_id                            = string
    ignore_missing_vnet_service_endpoint = bool
  }))
  default = []
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
