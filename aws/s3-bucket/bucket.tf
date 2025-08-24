resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "roi-"
  tags = {
    Name        = "My bucket"
    Environment = "Prod"
  }
}

# Make the default explicit (ACLs disabled)
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Block all public access (good hygiene)
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration { status = "Enabled" }
}
