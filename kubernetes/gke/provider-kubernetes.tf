data "google_client_config" "default" {}

provider "kubernetes" {
  load_config_file       = false
  host                   = "https://${google_container_cluster.gke-cluster.endpoint}"
  token                  = data.google_client_config.default.access_token
  client_certificate     = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_certificate)
  client_key             = base64decode(google_container_cluster.gke-cluster.master_auth.0.client_key)
  cluster_ca_certificate = base64decode(google_container_cluster.gke-cluster.master_auth.0.cluster_ca_certificate)
}
