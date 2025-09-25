provider "kubectl" {
  load_config_file       = false
  host                   = data.aws_eks_cluster.dev-eks-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.dev-eks-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.dev-eks-cluster.certificate_authority.0.data)
  # Add exec configuration for better compatibility
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = [
      "eks",
      "get-token",
      "--cluster-name",
      data.aws_eks_cluster.dev-eks-cluster.name,
      "--region",
      var.aws_region
    ]
  }

}



data "kubectl_file_documents" "namespace" {
  content = file("argocd/manifests/namespace.yaml")
}

data "kubectl_file_documents" "argocd" {
  content = file("argocd/manifests/install.yaml")
}

resource "kubectl_manifest" "namespace" {
  depends_on = [
    module.eks.cluster_name
  ]
  count              = length(data.kubectl_file_documents.namespace.documents)
  yaml_body          = element(data.kubectl_file_documents.namespace.documents, count.index)
  override_namespace = "argocd"
}

resource "kubectl_manifest" "argocd" {
  depends_on = [
    kubectl_manifest.namespace
  ]
  count              = length(data.kubectl_file_documents.argocd.documents)
  yaml_body          = element(data.kubectl_file_documents.argocd.documents, count.index)
  override_namespace = "argocd"
}

