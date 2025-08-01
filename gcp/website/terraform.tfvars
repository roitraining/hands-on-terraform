project = "space-invaders"
project_id = "your-terraform-project-id"

regions =  ["us-central1", "us-east1"]
instance_count = 2
startup_script = "install_space_invaders.sh"
spot = true
machine_type = "e2-micro"

subnet_cidrs = {
    us-central1 = "192.168.1.0/24",
    us-east1    = "192.168.2.0/24"
  }

