module "kubernetes_app" {
  source    = "../modules/website-config"
  project   = "${var.user_name}-space-invaders"
  container = "drehnstrom/space-invaders:v1.0"

  depends_on = [module.eks]
}
