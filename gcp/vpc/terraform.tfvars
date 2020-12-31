project = "my-project"
project_id = "terraform-123020"
zone = "us-central1-a"

regions = ["us-central1", "us-east1"]
subnet_cidrs = {
    us-central1 = "192.168.1.0/24"
    us-east1 = "192.168.2.0/24"
  }