resource "random_string" "gen-str" {
  length = 9
  special = false
  upper = false
  lower = true
  number = true
  min_numeric = 5
}

resource "azurerm_resource_group" "tf_rg" {
  name     = "${var.res_grp_name}-store-it-demo"
  location = var.res_grp_locale
  tags = var.tags
}

resource "azurerm_storage_account" "tf_az_store" {
  name                     = "azstore${random_string.gen-str.result}"
  resource_group_name      = azurerm_resource_group.tf_rg.name
  location                 = azurerm_resource_group.tf_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  tags = var.tags
}

resource "azurerm_storage_table" "tf-az-table" {
  name                 = "azstortbl${random_string.gen-str.result}"
  storage_account_name = azurerm_storage_account.tf_az_store.name
}

resource "azurerm_storage_queue" "tf_az_queue" {
  name = "azqueue${random_string.gen-str.result}"
  storage_account_name = azurerm_storage_account.tf_az_store.name
}

resource "azurerm_storage_table" "tf_az_table_2" {
  name = "aztable${random_string.gen-str.result}"
  storage_account_name = azurerm_storage_account.tf_az_store.name
}