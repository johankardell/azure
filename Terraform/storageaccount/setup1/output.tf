output "admin_user" {
  value = local.admin_username
}

output "public_ip" {
  value = azurerm_public_ip.vm1.ip_address
}