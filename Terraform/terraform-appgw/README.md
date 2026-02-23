# Application Gateway with Front Door

Azure Application Gateway behind Azure Front Door, with backend web servers in a peered VNet.

## Architecture

```
Internet → Front Door → Application Gateway (vnet-appgw) ←peering→ Web VNet (vnet-web)
                              ↓                                          ↓
                        frontend subnet                           web servers (x2)
```

## Deployment Order

The project is split into three separate Terraform roots that **must be applied in this order**:

```bash
# 1. Create the network infrastructure (VNets, subnets, peering, public IP)
cd network/
terraform init && terraform apply -auto-approve

# 2. Create the Application Gateway and Front Door (references network resources via data sources)
cd ../loadbalacing/
terraform init && terraform apply -auto-approve

# 3. Create the web server VMs (references the web subnet via data source)
cd ../webservers/
terraform init && terraform apply -auto-approve
```

`loadbalacing/` and `webservers/` use `data` sources that expect the resources created by `network/` to already exist (resource group `RG-APPGW`, VNet `vnet-appgw`, and resource group `RG-Vnet` with VNet `vnet-web`). Applying them out of order will fail.

## Teardown

Destroy in reverse order:

```bash
cd webservers/  && terraform destroy -auto-approve
cd ../loadbalacing/ && terraform destroy -auto-approve
cd ../network/  && terraform destroy -auto-approve
```
