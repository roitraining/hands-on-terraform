resource "aws_instance" "vm" {  
  ami           = "ami-025ca978d4c1d9825"
  instance_type = "t3.medium"

  tags = {
    Name = "${var.project}-vm"ami-025ca978d4c1d9825
  }
}
