resource "azurerm_resource_group" "main" {
  name     = "rg-${local.resource_suffix}"
  location = var.location

  tags = {
    project     = var.project
    environment = var.environment
    location    = var.location
    tool        = "terraform"
  }

  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
