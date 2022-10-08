resource "azurerm_log_analytics_workspace" "main" {
  name                       = "log-${local.resource_suffix}"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  daily_quota_gb             = var.log_analytics_workspace_daily_quota_gb
  retention_in_days          = var.log_analytics_workspace_retention_in_days
  internet_ingestion_enabled = false
}
