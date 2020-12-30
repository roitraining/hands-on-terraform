resource "aws_instance" "vm" {  
  ami           = "ami-0be2609ba883822ec"
  instance_type = "t2.micro"

  tags = {
    Name = "${var.project}-server"
  }
}
