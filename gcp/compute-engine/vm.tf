resource "google_compute_instance" "vm" {
  count        = 3
  name         = "${var.project_id}-server-${count.index}"
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["webserver"]

  metadata_startup_script = file("install_space-invaders.sh")

  scheduling {
    # If `spot` is true, disabled restart
    automatic_restart = !var.spot

    # If `spot` is true, provisioning model is SPOT,
    # otherwise it's STANDARD.
    provisioning_model = var.spot ? "SPOT" : "STANDARD"

    # If `spot` is true, the instance is preemptible.
    preemptible = var.spot
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
