resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage" {
  name                     = "${var.bucket_name}${random_string.random.result}"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  static_website {
    index_document     = var.home_page
    error_404_document = var.error_page
  }

  tags = var.tags
}
