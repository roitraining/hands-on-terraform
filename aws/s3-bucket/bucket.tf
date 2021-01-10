resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "roi-"
  acl           = "private"

  versioning {
    enabled = true
  }

  tags = {
    Name        = "My bucket"
    Environment = "Prod"
  }
}