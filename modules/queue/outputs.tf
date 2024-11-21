output "servicebus_queue_name" {
  description = "The name of this Service Bus queue."
  value       = azurerm_servicebus_queue.this.name
}
