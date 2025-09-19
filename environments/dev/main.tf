provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  #load_config_file  = "false"
  host                   = data.aws_eks_cluster.dev-eks-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.dev-eks-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.dev-eks-cluster.certificate_authority.0.data)

}


data "aws_eks_cluster" "dev-eks-cluster" {
  name = module.eks.cluster_name
  # Add explicit dependency
  depends_on = [module.eks]
}

data "aws_eks_cluster_auth" "dev-eks-cluster" {
  name = data.aws_eks_cluster.dev-eks-cluster.name
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
  source    = "../../modules/ecr"
  repo_name = "sobeam-dev"

  tags = {
    Environment = var.environment
    Project     = "Cloud-Migration"
  }
}

