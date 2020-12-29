module "website_bucket" {
  source = "./modules/website-bucket"

  bucket_name = "space-invaders-12-29-2020"
  home_page   = "index.html"
  error_page  = "index.html"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
