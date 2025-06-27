terraform {
  required_providers {
    sdm = {
      source = "strongdm/sdm"
      version = ">= 14.20.0"
    }
  }
}

resource "sdm_resource" "eks" {
  amazon_eks_instance_profile {
    name         = "${var.name}-eks"
    cluster_name = module.eks.cluster_name

    proxy_cluster_id = var.proxy_cluster_id

    identity_alias_healthcheck_username = "healthcheck"

    discovery_enabled = true
    discovery_username = "discovery"

    certificate_authority = base64decode(module.eks.cluster_certificate_authority_data)

    endpoint = module.eks.cluster_endpoint
    region   = var.aws_region

    # role_arn = var.worker_role_arn

    # When specified strongDM will inherit permissions from this role
    tags = merge({
      Name = "${var.name}-eks"
    }, var.tags)
  }
}