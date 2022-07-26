locals {
  private_dns_zones = {
    registry = "privatelink.azurecr.io"
    vault    = "privatelink.vaultcore.azure.net"
    cluster  = "privatelink.${var.location}.azmk8s.io"
  }

  resource_suffix = "${var.project}-${var.environment}-${var.region}"
  context_name    = "${var.project}-${var.environment}"
}
