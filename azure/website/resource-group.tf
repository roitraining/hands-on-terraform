resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-resource-group"
  location = var.location
}