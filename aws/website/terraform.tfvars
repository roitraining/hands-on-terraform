project = "space-invaders"

# VM variables
region = "us-east-1"
instance_type = "t2.micro"
instance_count_min = 2
instance_count_max = 6

# Network variables
vpc_cidr = "192.168.0.0/16"
subnet_a_cidr = "192.168.1.0/24"
subnet_b_cidr = "192.168.2.0/24"