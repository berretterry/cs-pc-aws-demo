module "cs_demo" {
  source = "./cs_demo"

  # Name will be added to resource names
  name                    = local.name

  # Tags will be added to strongDM and AWS resources.
  tags                    = local.tags

  # List of email addresses of existing StrongDM users who will receive access to all resources
  existing_users = local.existing_users

  #AWS Region you want resources deployed in
  aws_region              = local.aws_region

  #Comment this line out to create an rdp server
  create_rdp              = local.create_rdp

  #Comment this line out to create an ssh/web server
  create_ssh_web          = local.create_ssh_web

  #Comment this line out to create an eks cluster with discovery, impersonation, and identity alias
  create_eks              = local.create_eks

  #Comment this line out to create a mysql rds database
  create_db               = local.create_db
}
