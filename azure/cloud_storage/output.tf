output "resource_group_created" {
  value       = azurerm_resource_group.tf_rg.name
  description = "Resource group created`"
}

output "resource_group_created_location" {
  value       = azurerm_resource_group.tf_rg.location
  description = "Resource group created location"
}

output "resource_group_created_id" {
  value       = azurerm_resource_group.tf_rg.id
  description = "Resource group created location"
}

output "storage_account" {
  value = azurerm_storage_account.tf_az_store.name
  description = "storage account created"
}

output "storage_table_created" {
  value = azurerm_storage_table.tf-az-table.name
}

output "storage_table_created_id" {
  value = azurerm_storage_table.tf-az-table.id
}

output "second_storage_table_created" {
  value = azurerm_storage_table.tf_az_table_2.id
}
