module "kubernetes" {
  source = "../modules/kubernetes"

  project   = var.project
  container = "drehnstrom/space-invaders:v1.0"
}
