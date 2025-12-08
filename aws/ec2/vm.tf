resource "aws_instance" "vm" {
  count                  = 3
  ami                    = "ami-025ca978d4c1d9825"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow-http.id, aws_security_group.allow-ssh.id]

  user_data = file("install_space-invaders.sh")

  tags = {
    Name = "server-${count.index}"
  }
}
