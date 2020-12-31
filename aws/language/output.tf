output "instance_ids" {
  value = [for instance in aws_instance.vm : instance.id]
}

output "private_ip_addresses" {
  value       = [for instance in aws_instance.vm : instance.private_ip]
  description = "The private IP address of each server instance."
}

output "public_ip_addresses" {
  value       = [for instance in aws_instance.vm : instance.public_ip]
  description = "The public IP address of each server instance."
}