# Azure Service Bus Terraform module

[![SCM Compliance](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-service-bus/badge)](https://scm-compliance-api.radix.equinor.com/repos/equinor/terraform-azurerm-service-bus/badge)
[![Equinor Terraform Baseline](https://img.shields.io/badge/Equinor%20Terraform%20Baseline-1.0.0-blueviolet)](https://github.com/equinor/terraform-baseline)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

Terraform module which creates Azure Service Bus resources.

## Features

- Microsoft Entra authentication enforced by default.
- Public network access disabled by default.
- Audit logs sent to given Log Analytics workspace by default.

## Development

1. Clone this repository:

    ```console
    git clone https://github.com/equinor/terraform-azurerm-service-bus.git
    ```

1. Login to Azure:

    ```console
    az login
    ```

1. Set environment variables:

    ```console
    export ARM_SUBSCRIPTION_ID=<SUBSCRIPTION_ID>
    export TF_VAR_resource_group_name=<RESOURCE_GROUP_NAME>
    export TF_VAR_location=<LOCATION>
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
