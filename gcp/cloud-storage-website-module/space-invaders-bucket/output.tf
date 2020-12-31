output "name" {
  description = "Name of the bucket"
  value       = module.website_bucket.name
}

output "url" {
  description = "URL of the bucket"
  value       = module.website_bucket.url
}

output "self_link" {
  description = "Self Link of the bucket"
  value       = module.website_bucket.self_link
}
