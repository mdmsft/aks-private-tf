resource "azurerm_container_registry" "main" {
  name                   = "cr${var.project}${var.environment}${var.region}"
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  sku                    = var.container_registry_sku
  admin_enabled          = false
  anonymous_pull_enabled = false
}
