module "website_bucket" {
  source = "../modules/website-bucket"

  bucket_name = "space-invaders"
  home_page   = "index.html"
  error_page  = "index.html"

  tags = {
    website     = "space-invaders"
    environment = "prod"
  }
}



resource "null_resource" "run_script" {
  depends_on = [module.website_bucket]

  provisioner "local-exec" {
    command = "aws s3 sync s3://space-invaders-source s3://${module.website_bucket.bucket_name}"
  }
}



