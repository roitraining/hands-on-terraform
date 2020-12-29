resource "aws_instance" "vm" {
  count = var.instance_count
  ami           = var.image_id[var.region]
  instance_type = var.instance_type

  tags = {
    Name = "${var.project} server ${count.index}" 
  }
}

output "private_ip_addresses" {
  value       = [for instance in aws_instance.vm : instance.private_ip]
  description = "The private IP address of each server instance."
}

output "public_ip_addresses" {
  value       = [for instance in aws_instance.vm : instance.public_ip]
  description = "The public IP address of each server instance."
}