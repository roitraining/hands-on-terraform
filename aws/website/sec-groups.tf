resource "aws_security_group" "allow-http" {
  name        = "${var.account}-allow-http"
  description = "Enable HTTP Access"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "${var.account}-allow-http"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-ipv4" {
  security_group_id = aws_security_group.allow-http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow-http-outbound" {
  security_group_id = aws_security_group.allow-http.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_security_group" "allow-ssh" {
  name        = "${var.account}-allow-ssh"
  description = "Enable SSH Access"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "${var.account}-allow-ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4" {
  security_group_id = aws_security_group.allow-ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow-ssh-outbound" {
  security_group_id = aws_security_group.allow-ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
