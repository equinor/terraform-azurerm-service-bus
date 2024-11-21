resource "azurerm_servicebus_queue" "this" {
  for_each = var.queue

  name                 = each.value.name
  namespace_id         = var.namespace_id
  partitioning_enabled = each.value.partitioning_enabled
}
