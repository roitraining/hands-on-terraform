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

# allow rdp
resource "google_compute_firewall" "rdp" {
  name    = "${google_compute_network.vpc.name}-allow-rdp"
  network = google_compute_network.vpc.name
  allow {
    protocol = "tcp"
    ports    = ["3389"]
  }
  source_ranges = [
    "0.0.0.0/0"
  ]
  target_tags = ["allow-rdp"] 
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
  source_ranges = [for value in var.regions : var.subnet_cidrs[value]]
}