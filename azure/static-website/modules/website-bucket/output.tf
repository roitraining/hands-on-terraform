output "web_url" {
  value = azurerm_storage_account.storage.primary_web_endpoint
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.storage.primary_blob_endpoint
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}
