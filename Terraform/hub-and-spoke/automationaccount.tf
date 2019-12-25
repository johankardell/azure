resource "azurerm_automation_account" "automationaccount" {
  name                = var.automationaccount.name
  location            = var.location
  resource_group_name = azurerm_resource_group.automationaccount.name

  sku_name = "Basic"
}
