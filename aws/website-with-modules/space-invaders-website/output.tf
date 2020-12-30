output "load_balancer_address" {
  value       = module.load-balancer.load_balancer_address
  description = "The DNS name for the Load Balancer."
}
