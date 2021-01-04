output "load_balancer_address" {
  value = aws_elb.elb.dns_name
}

output "load_balancer_id" {
  value = aws_elb.elb.id
}

