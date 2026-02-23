# Copilot Instructions

This repository contains Azure sample scripts and infrastructure-as-code organized by tooling: Azure CLI (`AzureCLI/`), PowerShell (`AzurePowershell/`), Terraform (`Terraform/`), and Linux shell scripts (`Linux/`).

## Architecture

Each top-level directory targets a different Azure provisioning tool. Within `Terraform/`, each subdirectory is a standalone deployment (not a shared module) with its own state, variables, and provider config. There is no cross-directory dependency—each sample is self-contained.

Terraform samples use a hub-and-spoke pattern for networking where applicable, with role-based file splitting (e.g., `vnet_hub.tf`, `jumphost.tf`, `nsg.tf`) rather than Terraform modules.

## Conventions

### Terraform

- **Provider**: AzureRM v4.x with `terraform { required_providers {} }` block. Always include `features {}` in the provider block.
- Split resources into role-based `.tf` files per resource type (e.g., `vnet.tf`, `vm.tf`, `nsg.tf`), with `main.tf` for provider and resource groups.
- Use `variables.tf` for variable definitions and `*.tfvars` for values. Keep `output.tf` minimal—only expose critical values like public IPs.
- Group related configuration into map variables (`type = map(string)`) with kebab-case keys.
- Use `azurerm_linux_virtual_machine` (not the deprecated `azurerm_virtual_machine`).
- Use `address_prefixes` (list) on subnets, not the deprecated `address_prefix`.
- Use `azurerm_subnet_network_security_group_association` instead of `network_security_group_id` on subnets.
- Use `azurerm_service_plan` + `azurerm_linux_web_app` instead of the deprecated `azurerm_app_service_plan` + `azurerm_app_service`.
- Use `azurerm_cdn_frontdoor_*` resources instead of the classic `azurerm_frontdoor`.
- Ubuntu image reference: `Canonical` / `0001-com-ubuntu-server-noble` / `24_04-lts-gen2`.
- Default region is `westeurope` where a default is set.

### Azure CLI (Bash)

- Use `set -euo pipefail` for error handling.
- Use UPPER_SNAKE_CASE for shell variables (e.g., `LOCATION`, `VM_SIZE`, `VNET_PREFIX`).
- Scripts may use `.azcli` extension for Azure CLI-specific files.

### PowerShell

- Use PascalCase for variables (e.g., `$ResourceGroupName`, `$VNetAddressPrefix`).
- Use hashtables (`@{ }`) for structured resource configuration.
