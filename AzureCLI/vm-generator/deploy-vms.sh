#!/usr/bin/env bash
set -euo pipefail

SUBSCRIPTIONS=("one" "two" "three" "four" "five")
LOCATION="swedencentral"
VM_SIZE="Standard_D4as_v5"
VM_IMAGE="Ubuntu2204"
VNET_PREFIX="10.0.0.0/16"
SUBNET_PREFIX="10.0.0.0/24"

for sub in "${SUBSCRIPTIONS[@]}"; do
  rg="deleteme"
  vnet="vnet-vmgen-${sub}"
  subnet="default"
  vm="vm-vmgen-${sub}"

  echo "=== [$sub] Creating resource group $rg ==="
  az group create \
    --subscription "$sub" \
    --name "$rg" \
    --location "$LOCATION" \
    --output none

  echo "=== [$sub] Creating virtual network $vnet ==="
  az network vnet create \
    --subscription "$sub" \
    --resource-group "$rg" \
    --name "$vnet" \
    --address-prefix "$VNET_PREFIX" \
    --subnet-name "$subnet" \
    --subnet-prefix "$SUBNET_PREFIX" \
    --output none

  echo "=== [$sub] Creating VM $vm ==="
  az vm create \
    --subscription "$sub" \
    --resource-group "$rg" \
    --name "$vm" \
    --image "$VM_IMAGE" \
    --size "$VM_SIZE" \
    --vnet-name "$vnet" \
    --subnet "$subnet" \
    --public-ip-address "" \
    --generate-ssh-keys \
    --output none

  echo "=== [$sub] VM running — sleeping 60 seconds ==="
  sleep 60

  echo "=== [$sub] Deleting resource group $rg ==="
  az group delete \
    --subscription "$sub" \
    --name "$rg" \
    --yes \
    --output none

  echo "=== [$sub] Done ==="
done

echo "All subscriptions processed."
