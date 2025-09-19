provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "../../modules/vpc"

  vpc_name           = var.vpc_name
  vpc_cidr_block     = var.vpc_cidr_block
  availability_zones = var.availability_zones
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets

  tags = {
    Environment = var.environment
    Project     = "Cloud-Migration"
  }
}

module "eks" {
  source = "../../modules/eks"
  
  cluster_name    = "dev-eks-cluster"
  cluster_version = "1.33"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  desired_size = 2
  min_size     = 1
  max_size     = 3

  tags = {
    Environment = var.environment
    Project     = "Cloud-Migration"
  }
}

module "ecr" {
  source = "../../modules/ecr"
  repo_name = "sobeam-dev"

  tags = {
    Environment = var.environment
    Project     = "Cloud-Migration"
  }
}

