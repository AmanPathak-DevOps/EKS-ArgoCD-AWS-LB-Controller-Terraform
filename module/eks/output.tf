output "eks-cluster-endpoint" {
  value = aws_eks_cluster.eks[0].endpoint
}

output "private_subnet_ids" {
  value = data.aws_subnets.private_subnets.ids
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
