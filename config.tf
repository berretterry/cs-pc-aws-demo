locals {
  # Name will be added to resource names
  name                    = "bt-pc-demo"

  # Tags will be added to strongDM and AWS resources.
  tags                    = {
    project = "bt-pc-demo"
    workflow = "bt-pc-demo-workflow"
    }

  # List of email addresses of existing StrongDM users who will receive access to all resources
  existing_users = ["berret.terry+cssandbox@strongdm.com"]

  #AWS Region you want resources deployed in
  aws_region              = "us-west-2"

  #Change this to true to create an rdp server
  create_rdp              = false

  #Change this to true to create an ssh/web server
  create_ssh_web          = false

  #CChange this to true to create an eks cluster with discovery, impersonation, and identity alias
  create_eks              = true

  #Change this to true to create a mysql rds database
  create_db               = false
}