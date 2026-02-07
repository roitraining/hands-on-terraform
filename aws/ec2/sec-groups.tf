resource "aws_security_group" "allow-web-traffic" {
  name        = "allow-web-traffic"
  description = "Enable HTTP and SSH Access"

  tags = {
    Name = "allow-web-traffic"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow-http-ipv4-rule" {
  security_group_id = aws_security_group.allow-web-traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow-ssh-ipv4-rule" {
  security_group_id = aws_security_group.allow-web-traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow-outbound-traffic" {
  security_group_id = aws_security_group.allow-web-traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
