locals {
  deployer_role_name = split("/", data.aws_caller_identity.current.arn)[1]
}