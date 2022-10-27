terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.36.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.1.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

}

provider "aws" {
  region  = var.region
}

data "terraform_remote_state" "eks" {
  backend = "local"

  config = {
    path = "./terraform.tfstate"
  }
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.cluster.name
    ]
  }
}