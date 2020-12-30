output "load_balancer_address" {
  value = aws_lb.load_balancer.dns_name
}
