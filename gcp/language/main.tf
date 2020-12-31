resource "google_compute_instance" "vm" {
  count        = var.instance_count
  name         = "${var.project_id}-server-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  scheduling {
    automatic_restart = !var.preemptible
    preemptible       = var.preemptible
  }

  boot_disk {
    initialize_params {
      image = var.image_id[var.os_version]
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
  
}
