output "eks-cluster-endpoint" {
  value = aws_eks_cluster.eks[0].endpoint
}

output "eks-cluster-ca" {
  value = base64decode(aws_eks_cluster.eks[0].certificate_authority[0].data)
}

output "oidc-arn" {
  value = aws_iam_openid_connect_provider.eks-oidc.arn
}

output "oidc-url" {
  value = aws_iam_openid_connect_provider.eks-oidc.url
}
