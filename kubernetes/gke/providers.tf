terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}

provider "google" {
  credentials = file("~/terraform-key.json")

  project = var.project_id
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.gke-cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  client_certificate     = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.gke-cluster.master_auth.0.cluster_ca_certificate)
}
