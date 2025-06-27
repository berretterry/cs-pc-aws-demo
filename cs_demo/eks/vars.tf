variable "name" {
  description = "The name of the project"
  type        = string
}
variable "vpc_id" {
  description = "vpc id of the project"
  type        = string
}
variable "tags" {
  description = "Tags to be applied to reasources created by this module"
  type        = map(string)
  default     = {}
}
variable "pc_worker_sg" {
  description = "proxy cluster security group id"
  type        = string
}
variable "private_subnet_ids" {
  description = "Proxy Cluster Worker subnet id"
  type        = list(string)
}
variable "proxy_cluster_id" {
  description = "sdm proxy cluster id."
  type        = string
}
variable "aws_region" {
  description = "This is the region where your resources will be created"
  type = string
}

variable "worker_role_arn" {
  type = string
  description = "arn of the proxy worker role"
}

# variable "enabled" {
#   description = "modularizing the eks cluster resources"
#   type = bool
# }