resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.account}-vpc"
  }
}

# Note: "${var.region}a" / "b" works for all common classroom regions
# (us-east-1, us-east-2, us-west-2, eu-west-1, etc.)
resource "aws_subnet" "subnet-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_a_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.account}-vpc-subnet-a"
  }
}

resource "aws_subnet" "subnet-b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_b_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.account}-vpc-subnet-b"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.account}-vpc-ig"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.account}-public-rt"
  }
}

resource "aws_route_table_association" "public_subnet_a" {
  subnet_id      = aws_subnet.subnet-a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_subnet_b" {
  subnet_id      = aws_subnet.subnet-b.id
  route_table_id = aws_route_table.public_rt.id
}
