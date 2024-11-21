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
