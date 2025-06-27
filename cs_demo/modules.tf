module "infrastructure" {
  source                       = "./infrastructure"
  name                         = var.name
  aws_region                   = var.aws_region
  vpc_id                       = module.infrastructure.vpc_id
  tags                         = var.tags
  private_subnet_ids           = module.infrastructure.private_subnet_ids
  public_subnet_ids            = module.infrastructure.public_subnet_ids
  ingress_cidr_blocks          = var.ingress_cidr_blocks
  sdm_proxy_cluster_access_key = module.sdm.sdm_proxy_cluster_access_key
  sdm_proxy_cluster_secret_key = module.sdm.sdm_proxy_cluster_secret_key
  eks_role_arn                 = module.eks[0].eks_role_arn
}

module "sdm" {
  source                  = "./sdm"
  name                    = var.name
  nlb_address             = module.infrastructure.nlb_address
  tags                    = var.tags
  existing_users          = var.existing_users
  proxy_cluster_id        = module.sdm.proxy_cluster_id
}

module "rdp_server" {
  count            = var.create_rdp ? 1 : 0
  source           = "./rdp_server"
  name             = var.name
  tags             = var.tags
  subnet_id        = module.infrastructure.private_subnet_ids[0]
  pc_worker_sg     = module.infrastructure.worker_security_group_id
  vpc_id           = module.infrastructure.vpc_id
  proxy_cluster_id = module.sdm.proxy_cluster_id
}

module "ssh_server" {
  count            = var.create_ssh_web ? 1 : 0
  source           = "./ssh_server"
  name             = var.name
  tags             = var.tags
  ssh_pubkey       = data.sdm_ssh_ca_pubkey.this_key.public_key
  pc_worker_sg     = module.infrastructure.worker_security_group_id
  subnet_id        = module.infrastructure.private_subnet_ids[0]
  vpc_id           = module.infrastructure.vpc_id
  proxy_cluster_id = module.sdm.proxy_cluster_id
}

module "eks" {
  count                    = var.create_eks ? 1 : 0
  source                   = "./eks"
  name                     = var.name
  tags                     = var.tags
  aws_region               = var.aws_region
  private_subnet_ids       = module.infrastructure.private_subnet_ids
  vpc_id                   = module.infrastructure.vpc_id
  pc_worker_sg             = module.infrastructure.worker_security_group_id
  proxy_cluster_id         = module.sdm.proxy_cluster_id
  worker_role_arn          = module.infrastructure.worker_role_arn
}

module "database" {
  count             = var.create_db ? 1 : 0
  source            = "./database"
  name              = var.name
  tags              = var.tags
  pc_worker_sg      = module.infrastructure.worker_security_group_id
  subnet_ids        = module.infrastructure.private_subnet_ids
  vpc_id            = module.infrastructure.vpc_id
  proxy_cluster_id  = module.sdm.proxy_cluster_id
}


