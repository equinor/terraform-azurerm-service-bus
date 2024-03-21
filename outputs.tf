output "namespace_id" {
  description = "The ID of this Service Bus Namespace."
  value       = azurerm_servicebus_namespace.this.id
}

output "namespace_endpoint" {
  description = "The URL to access the ServiceBus Namespace."
  value       = azurerm_servicebus_namespace.this.endpoint
}

output "identity_principal_id" {
  description = "The Principal ID for the Service Principal associated with the Managed Service Identity of this ServiceBus Namespace. This value will be null if no identity is assigned."
  value       = try(azurerm_servicebus_namespace.this.identity[0].principal_id, null)
}

output "identity_tenant_id" {
  description = "The Tenant ID for the Service Principal associated with the Managed Service Identity of this ServiceBus Namespace. This value will be null if no identity is assigned."
  value       = try(azurerm_servicebus_namespace.this.identity[0].tenant_id, null)
}