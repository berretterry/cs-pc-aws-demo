locals {
  # Name will be added to resource names
  name                    = "project-name"

  # Tags will be added to strongDM and AWS resources.
  tags                    = {
    project = "${local.name}"
    }

  # List of email addresses of existing StrongDM users who will receive access to all resources
  # !!!Must be a valid email address IN the tenant you are trying to add resources to!!!
  existing_users          = ["example.email@example.com"]

  #AWS Region you want resources deployed in
  aws_region              = "aws-region"

  #Change this to true to create an rdp server
  create_rdp              = false

  #Change this to true to create an ssh/web server
  create_ssh_web          = true

  #CChange this to true to create an eks cluster with discovery, impersonation, and identity alias
  create_eks              = true

  #Change this to true to create a mysql rds database
  create_db               = true
}