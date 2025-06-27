output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "eks cluster endpoint"
}

output "eks_cluster_ca" {
  value       = module.eks.cluster_certificate_authority_data
  description = "eks cluster certificate"
}

output "eks_cluster_token" {
  value       = data.aws_eks_cluster_auth.this.token
  description = "eks cluster token"
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "deployer_arn" {
  value = data.aws_iam_role.deployer.arn
  description = "The ARN of the IAM role you are currently using to deploy this module"
}

output "eks_role_arn" {
  value = aws_iam_role.this_eks.arn
  description = "The ARN of the EKS IAM role that needs to assume the correct role for sdm access"
}
