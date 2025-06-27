output "eks_cluster_endpoint" {
  value       = module.eks[0].eks_cluster_endpoint
  description = "eks cluster endpoint"
}

output "eks_cluster_token" {
  value       = module.eks[0].eks_cluster_token
  description = "eks cluster token"
}

output "eks_cluster_ca" {
  value       = module.eks[0].eks_cluster_ca
  description = "eks cluster certificate"
}
output "eks_cluster_name" {
  value = module.eks[0].eks_cluster_name
  description = "eks cluster name"
}
