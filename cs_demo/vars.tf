variable "aws_region" {
  description = "This is the region where your resources will be created"
  type = string
}

variable "name" {
  description = "This name is applied to resources where applicable, e.g. titles and tags."
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "This tags will be added to both AWS and strongDM resources"
}

variable "ingress_cidr_blocks" {
  description = "A list of CIDR blocks from which to allow ingress traffic"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "existing_users" {
  type        = list(string)
  default     = []
  description = "A list of email addresses for existing accounts to be granted access to all resources."
}
variable "create_db" {
  type        = bool
  default     = false
  description = "Set to true to create an RDS instance with mysql"
}
variable "create_rdp" {
  type        = bool
  default     = false
  description = "Set to true to create an EC2 instance of a windows server"
}
variable "create_ssh_web" {
  type        = bool
  default     = false
  description = "Set to true to create an EC2 instance to test ssh and http connections"
}
variable "create_eks" {
  type        = bool
  default     = false
  description = "Set to true to create an EKS cluster"
}

# variable "eks_cluster_endpoint" {
#   type        = string
#   description = "eks cluster endpoint"
# }

# variable "eks_cluster_ca" {
#   type        = string
#   default     = module.eks.eks_cluster_ca
#   description = "eks cluster certificate"
# }

# variable "eks_cluster_token" {
#   type        = string
#   default     = module.eks.eks_cluster_token
#   description = "eks cluster token"
# }