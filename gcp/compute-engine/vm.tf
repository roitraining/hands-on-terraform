resource "google_compute_instance" "vm" {
  count        = 3
  name         = "${var.project_id}-server-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["webserver"]

  metadata_startup_script = file("install_space-invaders.sh")

  scheduling {
    automatic_restart = !var.preemptible
    preemptible       = var.preemptible
  }

  boot_disk {
    initialize_params {
      image = var.image_id
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}
