resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-rg"
  location = var.location
}

resource "random_string" "random" {
  length = 16
  special = false
  upper = false
}

resource "azurerm_storage_account" "storage" {
  name                     = "storage${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  allow_blob_public_access = true

  tags = {
    environment = "prod"
  }
}

resource "azurerm_storage_container" "container" {
  name                  = "blob-container"
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = "blob"
}