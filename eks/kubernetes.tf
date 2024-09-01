resource "aws_iam_role" "lb-controller-role" {
  name        = "example"
  description = "EKS service account role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = module.eks.oidc-arn
        }
        Condition = {
          StringEquals = {
            "${module.eks.oidc-url}:sub" = "system:serviceaccount:default:example"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "load_balancer_controller" {
  name        = "LoadBalancerControllerPolicy"
  description = "Policy for AWS LoadBalancerController"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAddresses",
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeInternetGateways",
          "ec2:DescribeVpcs",
          "ec2:DescribeVpcPeeringConnections",
          "ec2:DescribeSubnets",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeInstances",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeTags",
          "ec2:GetCoipPoolUsage",
          "ec2:DescribeCoipPools",
          "elasticloadbalancing:DescribeLoadBalancers",
          "elasticloadbalancing:DescribeLoadBalancerAttributes",
          "elasticloadbalancing:DescribeListeners",
          "elasticloadbalancing:DescribeListenerCertificates",
          "elasticloadbalancing:DescribeSSLPolicies",
          "elasticloadbalancing:DescribeRules",
          "elasticloadbalancing:DescribeTargetGroups",
          "elasticloadbalancing:DescribeTargetGroupAttributes",
          "elasticloadbalancing:DescribeTargetHealth",
          "elasticloadbalancing:DescribeTags"
        ]
        Resource = "*"
        Effect   = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lb-controller-policy-attachment" {
  role       = aws_iam_role.lb-controller-role.name
  policy_arn = aws_iam_policy.load_balancer_controller.arn
}

# Create the service account
resource "kubernetes_service_account" "lb-controller" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.lb-controller-role.arn
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lb-controller-policy-attachment,
  ]
}
