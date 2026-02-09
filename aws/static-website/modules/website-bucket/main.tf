# Random suffix for globally-unique bucket name
resource "random_string" "random" {
  length  = 16
  special = false
  upper   = false
}

# The bucket itself
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${var.bucket_name}-${random_string.random.result}"
  force_destroy = true # Lab-friendly; unsafe for production
  tags          = var.tags
}

# Keep ACLs OFF (modern default) and manage access by policy
resource "aws_s3_bucket_ownership_controls" "this" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# To allow a public website policy, do NOT block public policies on this bucket
resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false # allow a public bucket policy
  restrict_public_buckets = false # allow this bucket to be public
}

# New, non-deprecated website configuration resource
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.s3_bucket.id

  index_document {
    suffix = var.home_page
  }

  error_document {
    key = var.error_page
  }
}

# Public read for website content via policy (objects under /*)
data "aws_iam_policy_document" "public_read" {
  statement {
    sid     = "PublicReadGetObject"
    effect  = "Allow"
    actions = ["s3:GetObject"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.s3_bucket.bucket}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.public_read.json

  # Make sure ownership controls & public-access-block are applied first
  depends_on = [
    aws_s3_bucket_ownership_controls.this,
    aws_s3_bucket_public_access_block.this
  ]
}

