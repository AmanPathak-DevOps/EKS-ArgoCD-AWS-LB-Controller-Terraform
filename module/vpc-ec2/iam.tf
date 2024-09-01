resource "aws_iam_role" "iam-role" {
  name = var.ec2-iam-role
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "iam-role-policy" {
  name = var.ec2-iam-role-policy
  role = aws_iam_role.iam-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ssm:DescribeAssociation",
          "ssm:GetDeployablePatchSnapshotForInstance",
          "ssm:GetDocument",
          "ssm:DescribeDocument",
          "ssm:GetManifest",
          "ssm:GetParameter",
          "ssm:GetParameters",
          "ssm:ListAssociations",
          "ssm:ListInstanceAssociations",
          "ssm:PutInventory",
          "ssm:PutComplianceItems",
          "ssm:PutConfigurePackageResult",
          "ssm:UpdateAssociationStatus",
          "ssm:UpdateInstanceAssociationStatus",
          "ssm:UpdateInstanceInformation",
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel",
          "ec2messages:AcknowledgeMessage",
          "ec2messages:DeleteMessage",
          "ec2messages:FailMessage",
          "ec2messages:GetEndpoint",
          "ec2messages:GetMessages",
          "ec2messages:SendReply"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Effect: "Allow",
        Action: [
           "ec2messages:AcknowledgeMessage",
           "ec2messages:DeleteMessage",
           "ec2messages:FailMessage",
           "ec2messages:GetEndpoint",
           "ec2messages:GetMessages",
           "ec2messages:SendReply"
            ],
        Resource: "*"
        }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2-instance-profile" {
  name = var.ec2-iam-instance-profile
  role = aws_iam_role.iam-role.name
}