resource "azurerm_lb" "lb" {
  name                = "${var.project}-lb"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = var.public_ip_address_id
  }

  tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackEndAddressPool"
}

resource "azurerm_lb_probe" "probe" {
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.lb.id
  name                = "ssh-running-probe"
  port                = var.application_port
}

resource "azurerm_lb_rule" "lbnatrule" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = "http"
  protocol                       = "Tcp"
  frontend_port                  = var.application_port
  backend_port                   = var.application_port
  backend_address_pool_id        = azurerm_lb_backend_address_pool.bpepool.id
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.probe.id
}

resource "azurerm_virtual_machine_scale_set" "scale-set" {
  name                = "${var.project}-scaleset"
  location            = var.location
  resource_group_name = var.resource_group_name
  upgrade_policy_mode = "Manual"

  sku {
    name     = var.instance_size
    tier     = "Standard"
    capacity = var.instance_count
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "${var.project}-vm"
    admin_username       = var.admin_username
    admin_password       = var.admin_password
    custom_data          = base64encode(file(var.startup_script))
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_profile {
    name    = "networkprofile"
    primary = true

    ip_configuration {
      name                                   = "IPConfiguration"
      subnet_id                              = var.subnet_id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.bpepool.id]
      primary                                = true
    }
  }

  tags = var.tags
}