resource "azurerm_network_interface" "nic" {
  count               = var.instance_count
  name                = "nic-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "nic-config"
    subnet_id                     = azurerm_subnet.subnet-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip[count.index].id
  }
}

data "azurerm_public_ip" "ip" {
  count               = var.instance_count
  name                = azurerm_public_ip.publicip[count.index].name
  resource_group_name = azurerm_linux_virtual_machine.vm[count.index].resource_group_name
  depends_on          = [azurerm_linux_virtual_machine.vm]
}

resource "azurerm_public_ip" "publicip" {
  count               = var.instance_count
  name                = "myPublicIP-${count.index}"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
}



resource "azurerm_linux_virtual_machine" "vm" {
  count                           = var.instance_count
  name                            = "${var.project}-vm-${count.index}"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = var.location
  size                            = var.instance_size
  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic[count.index].id, ]
  custom_data                     = base64encode(file("install_space-invaders.sh"))
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}