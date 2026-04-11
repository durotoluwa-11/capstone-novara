terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "durootoluwa-terrafoam-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source = "../../modules/vpc"

  cluster_name       = var.cluster_name
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
}

module "iam" {
  source = "../../modules/iam"

  cluster_name = var.cluster_name
}

module "dns" {
  source = "../../modules/dns"

  domain_name  = var.domain_name
  cluster_name = var.cluster_name
}

module "s3" {
  source = "../../modules/s3"

  kops_state_bucket      = var.kops_state_bucket
  terraform_state_bucket = var.terraform_state_bucket
}
