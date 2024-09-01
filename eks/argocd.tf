resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
  depends_on = [ kubernetes_service_account.example ]
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.24.1"
  namespace = "argocd"
  create_namespace = true
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "server.ingress.enabled"
    value = "false"
  }

  depends_on = [ kubernetes_namespace.argocd, 
    helm_release.aws_load_balancer_controller
  ]
}

resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }

  depends_on = [ helm_release.argocd ]
}