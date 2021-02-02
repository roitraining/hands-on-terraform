output "load_balancer_dns" {
  value = aws_elb.elb.dns_name
}