# Create the Network
module "vpc" {
  source = "../modules/vpc"
  project = var.project
  regions = var.regions
  subnet_cidrs = {
    us-central1 = "192.168.1.0/24"
    us-east1    = "192.168.2.0/24"
  }
}

module "instance-group" {
  source = "../modules/instance-group"
  project = var.project
  regions = var.regions
  machine_type = "f1-micro"
  preemptible = true
  instance_count = 2
  startup_script = "install_space_invaders.sh"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.subnets
}

module "load-balancer" {
  source = "../modules/load-balancer"
  project = var.project
  regions = var.regions
  instance_group = module.instance-group.instance_group
}
