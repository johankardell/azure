output "Jumphost_IP" {
  value = "${azurerm_public_ip.jumphost.ip_address}"
}