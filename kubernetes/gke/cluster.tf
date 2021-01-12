resource "google_container_cluster" "gke-cluster" {
  name               = "${var.project}-cluster"
  location           = var.gcp_zone
  initial_node_count = 3

  node_config {
    preemptible  = true
    machine_type = "e2-small"
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}