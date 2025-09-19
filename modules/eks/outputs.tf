output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_id" {
  value = module.eks.cluster_id
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_arn" {
  value = module.eks.cluster_arn
}

output "node_group_role_arn" {
  value = module.eks.eks_managed_node_groups["default"].iam_role_arn
}
