$ResourceGroupName="RG-Network"
$VNetName="myVNet"
$VNetAddressPrefix="10.0.0.0/8"
$Location="West Europe"

New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Force

## First the simple way

$Subnet1Name="subnet-poc-01"
$Subnet1AddressPrefix="10.1.0.0/16"
$Subnet2Name="subnet-poc-02"
$Subnet2AddressPrefix="10.2.0.0/16"

$vnet = New-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName -AddressPrefix $VNetAddressPrefix -Location $Location -Subnet $Subnet1, $Subnet2

$Subnet1 = New-AzVirtualNetworkSubnetConfig -Name $Subnet1Name -AddressPrefix $Subnet1AddressPrefix
$Subnet2 = New-AzVirtualNetworkSubnetConfig -Name $Subnet2Name -AddressPrefix $Subnet2AddressPrefix
$vnet = New-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName -AddressPrefix $VNetAddressPrefix -Location $Location -Subnet $Subnet1, $Subnet2

$VNet | Set-AzVirtualNetwork

# And the pretty way

$subnets = @{
    "subnet-poc-1" = "10.0.1.0/24"
    "subnet-poc-2" = "10.0.2.0/24"    
}

$createdSubnet = @()

foreach($subnet in $subnets.GetEnumerator()) {
    $newSubnet = New-AzVirtualNetworkSubnetConfig -Name $subnet.Key -AddressPrefix $subnet.Value
    $createdSubnet += $newSubnet
}

$vnet = New-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VNetName -AddressPrefix $VNetAddressPrefix -Location $Location -Subnet $createdSubnet

$VNet | Set-AzVirtualNetwork

#Cleanup

Remove-AzResourceGroup -Name $ResourceGroupName