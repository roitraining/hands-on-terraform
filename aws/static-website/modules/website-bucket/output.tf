output "bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.s3_bucket.bucket
}

output "bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.s3_bucket.arn
}

output "website_endpoint" {
  description = "S3 static website endpoint"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "website_domain" {
  description = "S3 static website domain"
  value       = aws_s3_bucket_website_configuration.website.website_domain
}
