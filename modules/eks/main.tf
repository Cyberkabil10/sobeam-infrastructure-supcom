module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.3.1"

  name    = var.cluster_name
  kubernetes_version = var.cluster_version
    addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  # Optional
  endpoint_public_access = true

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  subnet_ids      = var.subnet_ids
  vpc_id          = var.vpc_id

  enable_irsa = true

  tags = var.tags

  eks_managed_node_groups = {
    default = {
      ami_type     = "AL2023_x86_64_STANDARD"
      desired_size = var.desired_size
      max_size     = var.max_size
      min_size     = var.min_size

      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"
    }
  }
}
