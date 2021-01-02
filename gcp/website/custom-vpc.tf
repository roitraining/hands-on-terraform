resource "google_compute_network" "vpc" {
  name                    = "${var.project}-vpc"
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "subnet_1" {
  name          = "${var.project}-subnet-${var.region}"
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc.name
  region        = var.region
}
