module "website_bucket" {
  source = "../modules/website-bucket"

  bucket_name     = "space-invaders"
  bucket_location = "US"
  home_page       = "index.html"
  error_page      = "index.html"

  tags = {
    website     = "space-invaders",
    environment = "prod"
  }
}

resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "gsutil cp -r gs://invaders.drehnstrom.com/* gs://${module.website_bucket.name}/"
  }
}
