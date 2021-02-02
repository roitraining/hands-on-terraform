output "website_url" {
  description = "URL to the Website Home Page"
  value       = "https://storage.googleapis.com/${google_storage_bucket.static-site.name}/${var.home_page}"
}

output "name" {
  description = "Name of the bucket"
  value       = google_storage_bucket.static-site.name
}