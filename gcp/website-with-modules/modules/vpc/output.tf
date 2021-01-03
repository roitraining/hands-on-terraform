output "vpc_id" {
  value = google_compute_network.vpc.id
}

output "subnets" {
  value = google_compute_subnetwork.subnets
}