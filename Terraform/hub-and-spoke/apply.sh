#!/bin/bash

terraform fmt
terraform apply --var-file=variables.tfvars  --var-file=override.tfvars