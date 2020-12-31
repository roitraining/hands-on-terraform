provider "google" {
    credentials = file("~/terraform-key.json")

  project = var.project_id
  region  = var.region
}