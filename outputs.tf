output "namespace_id" {
  description = "The ID of this Service Bus Namespace."
  value       = azurerm_servicebus_namespace.this.id
}

output "namespace_endpoint" {
  description = "The URL to access the ServiceBus Namespace."
  value       = azurerm_servicebus_namespace.this.endpoint
}
