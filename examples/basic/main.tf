provider "azurerm" {
  features {}
}

resource "random_id" "this" {
  byte_length = 8
}

module "log_analytics" {
  source = "github.com/equinor/terraform-azurerm-log-analytics?ref=v2.1.1"

  workspace_name      = "log-${random_id.this.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "servicebus" {
  # source = "github.com/equinor/terraform-azurerm-service-bus?ref=v0.0.0"
  source = "../.."

  namespace_name             = "servicebus-namespace-${random_id.this.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  sku                        = "Basic"
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
