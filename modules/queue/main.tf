


resource "azurerm_servicebus_queue" "this" {
  for_each = var.queue

  name                 = each.value.name
  namespace_id         = var.namespace_id
  partitioning_enabled = each.value.partitioning_enabled
}

resource "azurerm_servicebus_queue_authorization_rule" "this" {
  depends_on = [azurerm_servicebus_queue.this]
  for_each   = var.queue_authorization_rule

  name     = each.value.name
  queue_id = "${var.namespace_id}/queues/${each.value.queue_name}"
  listen   = each.value.listen
  send     = each.value.send
  manage   = each.value.manage
}
