resource "aws_vpc" "roi-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "roi-vpc"
  }
}

resource "aws_subnet" "subnet-a" {
  vpc_id     = aws_vpc.roi-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "roi-vpc-subnet-a"
  }
}

resource "aws_subnet" "subnet-b" {
  vpc_id     = aws_vpc.roi-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "roi-vpc-subnet-b"
  }
}
