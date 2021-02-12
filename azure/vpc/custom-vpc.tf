resource "random_string" "gen-str" {
  length = 9
  special = false
  upper = false
  lower = true
  number = true
  min_numeric = 4
}

resource "azurerm_resource_group" "tf-az-rg" {
  name     = "${var.prefix}-${random_string.gen-str.result}-${var.res_grp_name}"
  location = var.res_grp_locale
  tags = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name = "${var.prefix}-${random_string.gen-str.result}-vnet"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.tf-az-rg.location
  resource_group_name = azurerm_resource_group.tf-az-rg.name
  tags = var.tags
}

resource "azurerm_subnet" "subnet0" {
  name = "${var.prefix}-${random_string.gen-str.result}-tf-subnet"
  address_prefixes = [ "10.0.1.0/24" ]
  resource_group_name = azurerm_resource_group.tf-az-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_subnet" "subnet1" {
  name = "${var.prefix}-${random_string.gen-str.result}-tf-subnet"
  address_prefixes = [ "10.0.2.0/24" ]
  resource_group_name = azurerm_resource_group.tf-az-rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "nsg" {
  name = "${var.prefix}-${random_string.gen-str.result}-tf-vm-nsg"
  location = azurerm_resource_group.tf-az-rg.location
  resource_group_name = azurerm_resource_group.tf-az-rg.name
  tags = var.tags

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTPS"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "80"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
