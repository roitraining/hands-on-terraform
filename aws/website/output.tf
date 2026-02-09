output "load_balancer_dns" {
  value = aws_lb.web_alb.dns_name
}