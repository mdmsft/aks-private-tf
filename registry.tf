resource "azurerm_container_registry" "main" {
  name                   = "cr${var.project}${var.environment}${var.region}"
  location               = azurerm_resource_group.main.location
  resource_group_name    = azurerm_resource_group.main.name
  sku                    = "Premium"
  admin_enabled          = false
  anonymous_pull_enabled = false
}

module "registry_endpoint" {
  source                         = "./modules/endpoint"
  resource_group_name            = azurerm_resource_group.main.name
  resource_suffix                = "${local.resource_suffix}-cr"
  subnet_id                      = azurerm_subnet.endpoint.id
  private_connection_resource_id = azurerm_container_registry.main.id
  subresource_name               = "registry"
  private_dns_zone_id            = azurerm_private_dns_zone.main["registry"].id

  depends_on = [
    azurerm_container_registry.main
  ]
}
