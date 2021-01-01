output "name" {
  description = "Name (id) of the bucket"
  value       = google_storage_bucket.static-site.name
}

output "url" {
  description = "Domain name of the bucket"
  value       = google_storage_bucket.static-site.url
}

output "self_link" {
  description = "Domain name of the bucket"
  value       = google_storage_bucket.static-site.self_link
}
