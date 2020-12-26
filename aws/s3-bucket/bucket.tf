 resource "aws_s3_bucket" "bucket" {
  bucket_prefix = "roi-"
  acl    = "private"

  tags = {
    Name        = "ROI bucket"
  }
}