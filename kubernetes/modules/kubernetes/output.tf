output "lb_ip" {
  value = kubernetes_service.service.load_balancer_ingress[0].ip
}