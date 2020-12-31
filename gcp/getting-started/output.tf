output "public_ip_address" {
  value       = google_compute_instance.vm.network_interface.0.access_config.0.nat_ip
  description = "The public IP for the server."
}
