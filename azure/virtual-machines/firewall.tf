resource "azurerm_subnet" "AzureFirewallSubnet" {
  name = "AzureFirewallSubnet" # mandatory name -do not rename-
  address_prefixes = ["10.0.2.0/26"]
  virtual_network_name = azurerm_virtual_network.vpc.name
  resource_group_name = azurerm_resource_group.rg.name
}

# Create the public ip for Azure Firewall
resource "azurerm_public_ip" "azure_firewall_ip" {
  name = "firewall-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  allocation_method = "Static"
  sku = "Standard"
}

# Create the Azure Firewall
resource "azurerm_firewall" "firewall" {
  depends_on=[azurerm_public_ip.azure_firewall_ip]
  name = "${var.project}-firewall"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  ip_configuration {
    name = "${var.location}-azure-firewall-config"
    subnet_id = azurerm_subnet.AzureFirewallSubnet.id
    public_ip_address_id = azurerm_public_ip.azure_firewall_ip.id
  }
}

# Create a Azure Firewall Network Rule for Web access
resource "azurerm_firewall_network_rule_collection" "allow-web" {
  name = "azure-firewall-web-rule"
  azure_firewall_name = azurerm_firewall.firewall.name
  resource_group_name = azurerm_resource_group.rg.name
  priority = 101
  action = "Allow"
  rule {
    name = "HTTP"
    source_addresses = ["0.0.0.0/0"]
    destination_ports = ["80"]
    destination_addresses = ["*"]
    protocols = ["TCP"]  
  }
  rule {
    name = "HTTPS"
    source_addresses = ["0.0.0.0/0"]
    destination_ports = ["443"]
    destination_addresses = ["*"]
    protocols = ["TCP"]
  }
}