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

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v1.4.0"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
}

module "servicebus" {
  # source = "github.com/equinor/terraform-azurerm-service-bus?ref=v0.0.0"
  source = "../.."

  namespace_name             = "servicebus-namespace-${random_id.this.hex}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = azurerm_resource_group.this.location
  sku                        = "Basic"
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
