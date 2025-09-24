provider "helm" {
  kubernetes = {
    host                   = data.aws_eks_cluster.dev-eks-cluster.endpoint
    token                  = data.aws_eks_cluster_auth.dev-eks-cluster.token
    cluster_ca_certificate = base64decode(
      data.aws_eks_cluster.dev-eks-cluster.certificate_authority.0.data
    )
  }
}

resource "helm_release" "nginx_ingress" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.13.2"
  namespace        = "ingress"
  create_namespace = true
  depends_on = [
    module.eks.cluster_name
  ]
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  version          = "v1.18.2"
  set = {
    name  = "installCRDs"
    value = "true"
  }
  depends_on = [
    module.eks.cluster_name
  ]
}

/*resource "helm_release" "kube-prometheus-stack" {
  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "monitoring"
  values = [
    "${file("prom-stack-values.yaml")}"
  ]
  create_namespace = true
  depends_on = [
    module.eks.cluster_id,
    helm_release.nginx_ingress
  ]
}
resource "helm_release" "loki-stack" {
  name       = "loki-stack"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki-stack"
  namespace  = "monitoring"
  values = [
    "${file("loki-stack-value.yaml")}"
  ]
  create_namespace = true
  depends_on = [
    module.eks.cluster_id
  ]

}*/