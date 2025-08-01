terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.46.0"
    }
  }
}

provider "google" {
  credentials = file("~/terraform-key.json")

  project = var.project_id
  region  = var.region
  zone    = var.zone
}
