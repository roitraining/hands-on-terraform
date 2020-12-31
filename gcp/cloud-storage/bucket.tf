resource "random_string" "random" {
  length = 16
  special = false
  upper = false
}

resource "google_storage_bucket" "bucket" {
  name          = "my-bucket-${random_string.random.result}"
  location      = "US"
  storage_class = "STANDARD"
  force_destroy = true
  uniform_bucket_level_access = true
}