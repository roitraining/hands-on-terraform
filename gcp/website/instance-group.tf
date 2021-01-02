resource "google_compute_region_instance_group_manager" "instance_group" {
  name   = "${var.project}-instance-group"
  region = var.region
  version {
    instance_template = google_compute_instance_template.instance_template.id
    name              = "primary"
  }
  base_instance_name = "${var.project}-webserver"
  target_size        = var.instance_count
}

resource "google_compute_instance_template" "instance_template" {
  name         = "${var.project}-instance-template"
  machine_type = var.machine_type

  network_interface {
    network    = google_compute_network.vpc.id
    subnetwork = google_compute_subnetwork.subnet_1.id
    access_config {
    }
  }

  disk {
    source_image = data.google_compute_image.debian_image.self_link
    auto_delete  = true
    boot         = true
  }

  metadata_startup_script = file(var.startup_script)

  tags = ["webserver"]

  scheduling {
    automatic_restart = !var.preemptible
    preemptible       = var.preemptible
  }
}

