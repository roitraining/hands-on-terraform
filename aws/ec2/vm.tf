resource "aws_instance" "vm" {
  count                  = 3
  ami                    = "ami-0be2609ba883822ec"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.allow-http.id, aws_security_group.allow-ssh.id]

  user_data = file("install_space-invaders.sh")

  tags = {
    Name = "server-${count.index}"
  }
}
