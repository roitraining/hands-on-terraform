output "storage_endpoint" {
    value = azurerm_storage_account.storage.primary_blob_endpoint
}

output "storage_host" {
    value = azurerm_storage_account.storage.primary_blob_host
}