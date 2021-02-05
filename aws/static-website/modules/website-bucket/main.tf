resource "random_string" "random" {
  length = 16
  special = false
  upper = false
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}-${random_string.random.result}"

  force_destroy = true
  acl    = "public-read"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${var.bucket_name}-${random_string.random.result}/*"
            ]
        }
    ]
}
EOF

  website {
    index_document = var.home_page
    error_document = var.error_page
  }

  tags = var.tags
}
