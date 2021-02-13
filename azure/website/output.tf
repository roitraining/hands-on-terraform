 output "vmss_public_ip" {
     value = azurerm_public_ip.public_ip.fqdn
 }