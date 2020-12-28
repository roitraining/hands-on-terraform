resource "aws_instance" "vm" {
  count = var.instance_count
  ami           = var.image_id[var.region]
  instance_type = var.instance_type
  subnet_id = count.index % 2 == 0 ? aws_subnet.subnet-a.id : aws_subnet.subnet-b.id
  associate_public_ip_address = var.add_public_ip

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