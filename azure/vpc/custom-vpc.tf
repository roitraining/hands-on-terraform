resource "random_string" "gen-str" {
  length = 12
  special = false
  upper = false
  lower = true
  number = true
  min_numeric = 5
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
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  count = var.instance_count
  name = "${var.prefix}-vm-${count.index}-nic"
  location = azurerm_resource_group.tf-az-rg.location
  resource_group_name = azurerm_resource_group.terra_ref_rg.name
  tags = var.tags

  ip_configuration {
    name = "${var.prefix}-vm-nic-cfg"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  count = var.instance_count
  name = "${var.prefix}-az-tf-server-${count.index}-vm"
  location = azurerm_resource_group.tf-az-rg.location
  resource_group_name = azurerm_resource_group.terra_ref_rg.name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  vm_size = var.az_vm_size
  tags = var.tags

  storage_os_disk {
    name = "${var.prefix}-tf-os-disk-${count.index}"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "Premium_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer = "UbuntuServer"
    sku = lookup(var.sku,var.res_grp_locale)
    version = "latest"
  }

  os_profile {
    computer_name = "${var.prefix}-az-tf-vm"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}
