variable "name" {
  description = "This name is applied to resources where applicable, e.g. titles and tags."
  type        = string
}
variable "existing_users" {
  type        = list(string)
  default     = []
  description = "A list of email addresses for existing accounts to be granted access to all resources."
}

variable "nlb_address" {
  description = "This is the external dns of the nlb."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to reasources created by this module"
  type        = map(string)
  default     = {}
}
variable "proxy_cluster_id" {
  description = "sdm proxy cluster id."
  type        = string
}


