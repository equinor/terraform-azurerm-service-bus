resource "azurerm_servicebus_namespace" "this" {
  name                = var.servicebus_namespace_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.sku
}
