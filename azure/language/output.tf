output "instance_ids" {
  value = [for instance in azurerm_linux_virtual_machine.vm : instance.id]
}

output "private_ip_addresses" {
  value       = [for instance in azurerm_linux_virtual_machine.vm : instance.private_ip_address]
  description = "The private IP address of each server instance."
}

output "public_ip_addresses" {
  value       = [for instance in azurerm_linux_virtual_machine.vm : instance.public_ip_address]
  description = "The public IP address of each server instance."
}