data "aws_availability_zones" "available" {}

# --- Networking ---
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = { Name = "userxx-rds-vpc" }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false
  tags                    = { Name = "userxx-db-subnet-1" }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false
  tags                    = { Name = "userxx-db-subnet-2" }
}

resource "aws_db_subnet_group" "rds" {
  name       = "userxx-rds-subnet-group"
  subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  tags       = { Name = "userxx-rds-subnet-group" }
}

# --- Security Group (Modern Rules) ---
resource "aws_security_group" "rds" {
  name        = "userxx-rds-sg"
  description = "Allow Postgres Access"
  vpc_id      = aws_vpc.main.id

  tags = { Name = "userxx-rds-sg" }
}

# Allow Postgres port (5432) from everywhere (for lab simplicity)
resource "aws_vpc_security_group_ingress_rule" "postgres" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5432
  ip_protocol       = "tcp"
  to_port           = 5432
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.rds.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# --- RDS Postgres ---
resource "aws_db_instance" "postgres" {
  identifier        = "userxx-rds-postgres"
  engine            = "postgres"
  engine_version    = "16.3"
  instance_class    = "db.t4g.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = "appdb"
  username = var.db_username

  # Modern Security: Let AWS manage the password in Secrets Manager
  manage_master_user_password = true

  db_subnet_group_name   = aws_db_subnet_group.rds.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false

  # Lab settings for easy destruction
  skip_final_snapshot = true
  deletion_protection = false

  tags = { Name = "userxx-rds-postgres" }
}
