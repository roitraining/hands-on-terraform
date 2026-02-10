terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.31"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.8"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.2"
    }

    cloudinit = {
      source  = "hashicorp/cloudinit"
      version = "~> 2.3"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.38"  # Stay on 2.x - v3.0 has breaking changes
    }
  }

  required_version = ">= 1.5.7"
}


provider "aws" {
  region = var.region
}


provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    command     = "aws"
    args = [
      "eks", "get-token",
      "--cluster-name", module.eks.cluster_name,
      "--region", var.region
    ]
  }
}
