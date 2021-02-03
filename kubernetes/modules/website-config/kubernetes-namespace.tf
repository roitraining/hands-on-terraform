resource "kubernetes_namespace" "n" {
  metadata {
    name = "${var.project}-ns"
  }
}