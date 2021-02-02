output "website_url" {
  description = "URL of the Static Website "
  value       = module.website_bucket.website_url
}

output "bucket_name" {
  description = "Bucket name"
  value       = module.website_bucket.name
}