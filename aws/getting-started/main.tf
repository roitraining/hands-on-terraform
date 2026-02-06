resource "aws_instance" "vm" {
  ami           = "ami-03ea746da1a2e36e7"
  instance_type = "t3.medium"

  tags = {
    Name = "${var.account}-vm"
  }
}
