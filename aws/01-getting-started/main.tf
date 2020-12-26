terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "vm" {  
  ami           = "ami-0be2609ba883822ec"
  instance_type = "t2.micro"

  tags = {
    Name = "my-server"
  }
}
