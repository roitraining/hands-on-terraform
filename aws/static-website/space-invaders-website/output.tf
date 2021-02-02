output "website_bucket_arn" {
  description = "ARN of the bucket"
  value       = module.website_bucket.arn
}

output "website_bucket_name" {
  description = "Name (id) of the bucket"
  value       = module.website_bucket.name
}

output "website_endpoint" {
  description = "Domain name of the bucket"
  value       = module.website_bucket.website_endpoint
}