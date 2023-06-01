provider "azurerm" {
  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

resource "azurerm_resource_group" "this" {
  name     = "rg-${random_id.this.hex}"
  location = var.location
}

module "servicebus" {
  # source = "github.com/equinor/terraform-azurerm-service-bus?ref=v0.0.0"
  source = "../.."

  servicebus_namespace_name = "servicebus-namespace-${random_id.this.hex}"
  resource_group_name       = azurerm_resource_group.this.name
  location                  = azurerm_resource_group.this.location
  sku                       = "Basic"
}
