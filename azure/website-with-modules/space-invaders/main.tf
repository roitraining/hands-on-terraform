resource "azurerm_resource_group" "rg" {
  name     = "${var.project}-resource-group"
  location = var.location
}

module "vpc" {
  source              = "../modules/vpc"
  project             = var.project
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

module "scale-set" {
  source               = "../modules/scale-set"
  project              = var.project
  location             = var.location
  resource_group_name  = azurerm_resource_group.rg.name
  instance_size        = "Standard_A1_v2"
  instance_count       = 3
  admin_username       = "doug"
  admin_password       = "$ecretPa$$w0rd"
  startup_script       = "install_space-invaders.sh"
  public_ip_address_id = module.vpc.public_ip.id
  subnet_id            = module.vpc.subnet.id
}
