resource "azurerm_key_vault" "main" {
  name                       = substr("kv-${var.project}-${var.environment}-${var.region}", 0, 24)
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  enable_rbac_authorization  = true
  sku_name                   = "standard"
  tenant_id                  = var.tenant_id
  soft_delete_retention_days = var.key_vault_soft_delete_retention_days

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
  }
}

resource "azurerm_role_assignment" "key_vault_administrator" {
  role_definition_name = "Key Vault Administrator"
  scope                = azurerm_key_vault.main.id
  principal_id         = data.azurerm_client_config.main.object_id
}

resource "azurerm_role_assignment" "key_vault_secrets_user" {
  role_definition_name = "Key Vault Secrets User"
  scope                = azurerm_key_vault.main.id
  principal_id         = azurerm_kubernetes_cluster.main.key_vault_secrets_provider[0].secret_identity[0].object_id
}

module "vault_endpoint" {
  source                         = "./modules/endpoint"
  resource_group_name            = azurerm_resource_group.main.name
  resource_suffix                = "${local.resource_suffix}-kv"
  subnet_id                      = azurerm_subnet.endpoint.id
  private_connection_resource_id = azurerm_key_vault.main.id
  subresource_name               = "vault"
  private_dns_zone_id            = azurerm_private_dns_zone.main["vault"].id
  
  depends_on = [
    azurerm_key_vault.main
  ]
}
