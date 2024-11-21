output "namespace_name" {
  description = "The name of this Service Bus namespace."
  value       = azurerm_servicebus_namespace.this.name
}

output "namespace_id" {
  description = "The ID of this Service Bus namespace."
  value       = azurerm_servicebus_namespace.this.id
}

output "namespace_endpoint" {
  description = "The URL to access this ServiceBus namespace."
  value       = azurerm_servicebus_namespace.this.endpoint
}

output "identity_principal_id" {
  description = "The principal ID of the system-assigned identity of this Service Bus namespace. Value is null if the system-assigned identity is disabled."
  value       = try(azurerm_servicebus_namespace.this.identity[0].principal_id, null)
}

output "identity_tenant_id" {
  description = "The tenant ID of the system-assigned identity of this Service Bus namespace. Value is null if the system-assigned identity is disabled."
  value       = try(azurerm_servicebus_namespace.this.identity[0].tenant_id, null)
}
