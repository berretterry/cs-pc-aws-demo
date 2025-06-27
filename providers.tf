terraform {
  required_version = ">= 0.14.0"
  required_providers {
    sdm = {
      source = "strongdm/sdm"
      version = ">= 14.20.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = ">= 4.33.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
    kubernetes = {
      source   = "hashicorp/kubernetes"
      version  = "2.37.1"
    }
  }
  #   backend "s3" {
  #     bucket = "bterry-lab"
  #     key = "bterry-lab/terraform.tfstate"
  #     region = module.cs_demo.aws_region
  # }
}
provider "aws" {
  region  = local.aws_region
}

