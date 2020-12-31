resource "aws_instance" "vm" {
  count         = var.instance_count
  ami           = var.image_id[var.region]
  instance_type = var.instance_type

  tags = {
    Name = "${var.project}-server-${count.index}"
  }
}