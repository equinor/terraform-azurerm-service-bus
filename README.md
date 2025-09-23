# Terraform module for Azure Service Bus

[![GitHub Release](https://img.shields.io/github/v/release/equinor/terraform-azurerm-service-bus)](https://github.com/equinor/terraform-azurerm-service-bus/releases/latest)
[![Terraform Module Downloads](https://img.shields.io/terraform/module/dt/equinor/service-bus/azurerm)](https://registry.terraform.io/modules/equinor/service-bus/azurerm/latest)
[![GitHub contributors](https://img.shields.io/github/contributors/equinor/terraform-azurerm-service-bus)](https://github.com/equinor/terraform-azurerm-service-bus/graphs/contributors)
[![GitHub Issues](https://img.shields.io/github/issues/equinor/terraform-azurerm-service-bus)](https://github.com/equinor/terraform-azurerm-service-bus/issues)
[![GitHub Pull requests](https://img.shields.io/github/issues-pr/equinor/terraform-azurerm-service-bus)](https://github.com/equinor/terraform-azurerm-service-bus/pulls)
[![GitHub License](https://img.shields.io/github/license/equinor/terraform-azurerm-service-bus)](https://github.com/equinor/terraform-azurerm-service-bus/blob/main/LICENSE)

Terraform module which creates Azure Service Bus resources.

## Features

- Microsoft Entra authentication enforced by default.
- Public network access disabled by default.
- Audit logs sent to given Log Analytics workspace by default.

## Prerequisites

- Azure role `Contributor` at the resource group scope.
- Azure role `Log Analytics Contributor` at the Log Analytics workspace scope.

## Usage

```terraform
provider "azurerm" {
  features {}
}

module "service_bus" {
  source  = "equinor/service-bus/azurerm"
  version = "~> 1.8"

  namespace_name             = "example-namespace"
  resource_group_name        = azurerm_resource_group.example.name
  location                   = azurerm_resource_group.example.location
  log_analytics_workspace_id = module.log_analytics.workspace_id
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "westeurope"
}

module "log_analytics" {
  source  = "equinor/log-analytics/azurerm"
  version = "~> 2.4"

  workspace_name      = "example-workspace"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
}
```

## Testing

1. Initialize working directory:

    ```console
    terraform init
    ```

1. Execute tests:

    ```console
    terraform test
    ```

    See [`terraform test` command documentation](https://developer.hashicorp.com/terraform/cli/commands/test) for options.

## Contributing

See [Contributing guidelines](https://github.com/equinor/terraform-baseline/blob/main/CONTRIBUTING.md).
