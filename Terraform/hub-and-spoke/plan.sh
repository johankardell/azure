#!/bin/bash

terraform fmt
terraform plan --var-file=variables.tfvars --var-file=override.tfvars