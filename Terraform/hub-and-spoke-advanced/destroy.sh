#!/bin/bash

terraform destroy --var-file=variables.tfvars --var-file=override.tfvars

# terraform destroy --var-file=variables.tfvars -target=azurerm_virtual_machine.ubuntu_spoke_vm