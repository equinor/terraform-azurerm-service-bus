variable "namespace_id" {
  description = "The Id of this Service Bus namespace."
  type        = string
  nullable    = false
}

variable "queue" {
  description = "Manages a ServiceBus Queue."
  type = map(object({
    name                 = string
    partitioning_enabled = optional(bool, false)
  }))
  default = {}
}
