data "tls_certificate" "eks-certificate" {
  url = aws_eks_cluster.eks[0].identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "eks_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks-oidc.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-test"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks-oidc.arn]
      type        = "Federated"
    }
  }
}

data "aws_vpc" "vpc" {
    filter {
        name = "tag:Name"
        values = [var.vpc-name]
    }
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:kubernetes.io/role/internal-elb"
    values = ["1"]
  }

  filter {
    name   = "tag:Env"
    values = [var.env]
  }
}



data "aws_security_group" "eks-cluster-sg" {
  name = var.eks-sg

#   filter {
#     name   = "vpc-id"
#     values = [data.aws_vpc.vpc.id]
#   }

#   filter {
#     name   = "tag:Env"
#     values = [var.env]
#   }
}
