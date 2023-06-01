variable "servicebus_namespace_name" {
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
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
