
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.8.4"
  cluster_name    = local.cluster_name
  cluster_version = var.kubernetes_version
  subnet_ids      = module.vpc.private_subnets

  enable_irsa = true
  cluster_endpoint_public_access  = true

  tags = {
    cluster = "my-cluster"
  }

  vpc_id = module.vpc.vpc_id

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t3.medium"]
    vpc_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  }

  eks_managed_node_groups = {
    "node_group" = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }
  enable_cluster_creator_admin_permissions = true
}
/*
# Use the root account as the principal
variable "account_id" {
  default = "836759839628"  # Replace with your account ID
}

# IAM Role for EKS Access
resource "aws_iam_role" "eks_cluster_access_role" {
  name = "EKSClusterAccessRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${var.account_id}:root"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

# Attach AmazonEKSClusterPolicy to the IAM Role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_access_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"  # Use available policy
}

# (Optional) If you find a suitable admin policy, you can attach it similarly.
# Remove the optional block if not needed.
# resource "aws_iam_role_policy_attachment" "eks_admin_policy_attachment_optional" {
#   role       = aws_iam_role.eks_cluster_access_role.name
#   policy_arn = "arn:aws:iam::aws:policy/<suitable-policy-arn>"  # Use the correct policy ARN
# }

# Output the IAM Role ARN
output "eks_cluster_access_role_arn" {
  value       = aws_iam_role.eks_cluster_access_role.arn
  description = "The ARN of the IAM role used for EKS access entry."
}
*/
