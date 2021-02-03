resource "kubernetes_deployment" "deployment" {
  metadata {
    name = "${var.project}-deployment"
    labels = {
      App = var.project
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 3
    progress_deadline_seconds = 300
    selector {
      match_labels = {
        App = var.project
      }
    }
    template {
      metadata {
        labels = {
          App = var.project
        }
      }
      spec {
        container {
          image = var.container
          name  = var.project

          port {
            container_port = 80
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}