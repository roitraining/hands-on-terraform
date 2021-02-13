resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-resource-group"
  location = var.location
}

resource "azurerm_virtual_network" "vpc" {
  name                = "${var.project}-network"
  address_space       = var.vpc_cidr
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  for_each             = var.subnet_cidrs
  name                 = "subnet-${each.key}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vpc.name
  address_prefixes     = [each.value]
}