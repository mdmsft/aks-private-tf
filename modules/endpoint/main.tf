data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

resource "azurerm_private_endpoint" "registry" {
  name                = "pe-${var.resource_suffix}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  subnet_id           = var.subnet_id

  private_dns_zone_group {
    name                 = reverse(split("/", var.private_dns_zone_id))[0]
    private_dns_zone_ids = [var.private_dns_zone_id]
  }

  private_service_connection {
    name                           = reverse(split("/", var.private_connection_resource_id))[0]
    is_manual_connection           = false
    subresource_names              = [var.subresource_name]
    private_connection_resource_id = var.private_connection_resource_id
  }
}
