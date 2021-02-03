module "kubernetes" {
  source = "../modules/space-invaders-config"

  project   = var.project
  container = "drehnstrom/space-invaders:v1.0"
}
