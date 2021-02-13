 output "public_ip" {
     value = azurerm_public_ip.public_ip
 }

  output "load_balancer" {
     value = azurerm_public_ip.public_ip
 }

 output "vpc" {
     value = azurerm_virtual_network.vpc
 }

  output "subnet" {
     value = azurerm_subnet.subnet-1
 }

