data "aws_availability_zones" "available" {}

# --- Networking (no IGW/NAT needed just to create RDS) ---
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "minimal-vpc" }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags                    = { Name = "db-subnet-1" }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  tags                    = { Name = "db-subnet-2" }
}

# RDS requires a subnet group spanning >=2 AZs
resource "aws_db_subnet_group" "rds" {
  name       = "minimal-rds-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  tags       = { Name = "minimal-rds-subnet-group" }
}

# Simple SG for MySQL (adjust to your IP or VPC peers)
resource "aws_security_group" "rds" {
  name        = "minimal-rds-sg"
  description = "Allow MySQL from a specific CIDR"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.ingress_cidr] # CHANGE THIS (avoid 0.0.0.0/0)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "minimal-rds-sg" }
}

# --- RDS MySQL ---
resource "aws_db_instance" "mysql" {
  identifier                 = "minimal-mysql"
  engine                     = "mysql"
  engine_version             = "8.4.5"        # pin an 8.4.x minor; adjust to what's available in your region
  instance_class             = "db.t4g.micro" # or db.t3.micro if you need x86
  allocated_storage          = 20
  storage_type               = "gp3"
  auto_minor_version_upgrade = true

  db_name  = "appdb"
  username = var.db_username
  password = var.db_password # mark variable as sensitive

  db_subnet_group_name   = aws_db_subnet_group.rds.name # two+ AZ subnets
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false

  skip_final_snapshot = true  # dev only
  deletion_protection = false # consider true in prod
  tags                = { Name = "minimal-mysql" }
}

output "rds_endpoint" {
  value = aws_db_instance.mysql.address
}