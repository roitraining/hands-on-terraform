resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-rg"
  location = var.location
}

resource "azurerm_mysql_server" "db-server" {
  name                = "${var.project}-mysqlserver"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  administrator_login          = "steve"
  administrator_login_password = "$ecretPa$$w0rd"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = false
  infrastructure_encryption_enabled = false
  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "database" {
  name                = "mydb"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.db-server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}
