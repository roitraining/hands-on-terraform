output "lb_status" {
  value = kubernetes_service.service.status
}