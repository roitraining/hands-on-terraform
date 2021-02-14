module "kubernetes" {
  source = "../modules/website-config"

  project   = var.project
  container = "drehnstrom/space-invaders:v1.0"
}
