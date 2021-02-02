resource "random_string" "random" {
  length  = 16
  special = false
  upper   = false
}

resource "google_storage_bucket" "static-site" {
  name          = "${var.bucket_name}-${random_string.random.result}"
  location      = var.bucket_location
  force_destroy = true

  uniform_bucket_level_access = true

  labels = var.tags

  website {
    main_page_suffix = var.home_page
    not_found_page   = var.error_page
  }
}

resource "google_storage_bucket_iam_member" "member" {
  bucket = google_storage_bucket.static-site.name
  role = "roles/storage.objectViewer"
  member = "allUsers"
}