module "eks" {
  # count           = var.enabled ? 1 : 0
  source          = "terraform-aws-modules/eks/aws"
  version         = ">= 20.8.4"
  cluster_name    = "${var.name}-eks"
  cluster_version = "1.32"
  subnet_ids      = var.private_subnet_ids
  vpc_id          = var.vpc_id

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  tags = merge({ Name = "${var.name}-eks" }, var.tags)

  access_entries = {
    strongdm = {
      principal_arn     = aws_iam_role.this_eks.arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type       = "namespace"
            namespaces = ["identity"]
          }
        }
      }
      pod_identity_associations = [
        {
          namespace         = "identity"
          service_account   = "impersonator-sa"
        }
      ]
    }

    strongdm_worker = {
      principal_arn = var.worker_role_arn
      policy_associations = {
        admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
    deployer = {
      principal_arn = data.aws_iam_role.deployer.arn

      policy_associations = {
        full = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }

  cluster_security_group_additional_rules = {
    strongdm = {
      description              = "Allow traffic from proxy workers to API endpoint"
      protocol                 = "tcp"
      from_port                = 443
      to_port                  = 443
      type                     = "ingress"
      source_security_group_id = var.pc_worker_sg
    }
  }
}

