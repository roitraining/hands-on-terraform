resource "aws_vpc" "custom-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "custom-vpc"
  }
}

resource "aws_subnet" "subnet-a" {
  vpc_id     = aws_vpc.custom-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "custom-vpc-subnet-a"
  }
}

resource "aws_subnet" "subnet-b" {
  vpc_id     = aws_vpc.custom-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "custom-vpc-subnet-b"
  }
}

resource "aws_internet_gateway" "custom-gw" {
  vpc_id = aws_vpc.custom-vpc.id

  tags = {
    Name = "custom-vpc-ig"
  }
}

resource "aws_default_route_table" "custom-rt" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.custom-gw.id
  }
  default_route_table_id = aws_vpc.custom-vpc.default_route_table_id
}