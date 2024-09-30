provider "azurerm" {
  features {}
}

resource "random_id" "suffix" {
  byte_length = 8
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "2.2.3"

  workspace_name      = "log-${random_id.suffix.hex}"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "service_bus" {
  # source  = "equinor/service-bus/azurerm"
  source = "../.."

  namespace_name             = "sbns-${random_id.suffix.hex}"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
}
