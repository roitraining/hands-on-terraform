# allow http
resource "google_compute_firewall" "allow-http" {
  name    = "${google_compute_network.vpc.name}-allow-http"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
  target_tags = ["webserver"]
}

# allow ssh
resource "google_compute_firewall" "allow-ssh" {
  name    = "${google_compute_network.vpc.name}-allow-ssh"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
  target_tags = ["allow-ssh"]
}

# allow ping only from everywhere
resource "google_compute_firewall" "allow-ping" {
  name    = "${google_compute_network.vpc.name}-allow-ping"
  network = google_compute_network.vpc.name
  allow {
    protocol = "icmp"
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
}

# Allow internal traffic on all ports
resource "google_compute_firewall" "allow-internal" {
  name    = "${google_compute_network.vpc.name}-allow-internal"
  network = google_compute_network.vpc.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [for region in var.regions: var.subnet_cidrs[region]] 
}
