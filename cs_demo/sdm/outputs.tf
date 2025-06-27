output "proxy_cluster_id" {
  value       = sdm_node.proxy-cluster.id
  description = "The ID of the proxy cluster"
}

output "sdm_proxy_cluster_secret_key" {
  value       = sdm_proxy_cluster_key.this.secret_key
  description = "The secret key of the proxy cluster"
}

output "sdm_proxy_cluster_access_key" {
  value       = sdm_proxy_cluster_key.this.id
  description = "The access key of the proxy cluster"
}