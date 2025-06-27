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
variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = "Existing private subnet IDs to deploy resources in; if not set, defaults to public_subnet_ids"
}
variable "proxy_cluster_id" {
  description = "sdm proxy cluster id."
  type        = string
}