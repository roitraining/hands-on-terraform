module "kubernetes_app" {
  source    = "../modules/website-config" # <— your module path
  project   = "space-invaders"
  container = "drehnstrom/space-invaders:v1.0"

  # wait until cluster + aws-auth exist
  depends_on = [module.eks]
}
