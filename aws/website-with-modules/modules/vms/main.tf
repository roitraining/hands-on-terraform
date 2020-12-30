resource "aws_instance" "vm" {
  count                       = var.instance_count
  ami                         = var.image_id[var.region]
  instance_type               = var.instance_type
  subnet_id                   = count.index % 2 == 0 ? var.subnet_a_id : var.subnet_b_id
  associate_public_ip_address = var.add_public_ip
  vpc_security_group_ids      = [var.allow_http_id, var.allow_ssh_id]
  key_name                    = "my-key-pair"

  user_data = file(var.startup_script)

  tags = {
    Name    = "${var.project} server ${count.index}"
    Project = var.project
  }
}