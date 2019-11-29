#!/bin/bash

az ad sp create-for-rbac -n terraform_aks_app --skip-assignment
az ad sp show --id terraform_aks_app --query objectId