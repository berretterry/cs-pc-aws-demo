terraform {
  required_providers {
    sdm = {
      source = "strongdm/sdm"
      version = ">= 14.20.0"
    }
  }
}

#Create a role to attach to users to use the workflow
resource "sdm_role" "admins" {
  name         = "${var.name}-admin-role"
  # access_rules = jsonencode([
  #   { tags = { CreatedBy = "strongDM-Onboarding" } }
  # ])
}

#Attach existing users to the role provided
resource "sdm_account_attachment" "existing_users" {
  count      = length(var.existing_users)
  account_id = element(data.sdm_account.existing_users[count.index].ids, 0)
  role_id    = sdm_role.admins.id
}

#create the approval workflow and determine if it is manual or automatic. This example is automatic manual example can be found in our terraform provider: https://registry.terraform.io/providers/strongdm/sdm/latest/docs/resources/approval_workflow
resource "sdm_approval_workflow" "this" {
    name = "${var.name} approval workflow"
    approval_mode = "automatic"
}

#create the actual workflow
resource "sdm_workflow" "this" {
    name         = "${var.name} automatic workflow"
    auto_grant   = true
    enabled      = true
    approval_flow_id = sdm_approval_workflow.this.id
    description  = "${var.name} automatic workflow"
    access_rules = jsonencode([
    {
      "tags" : {
        "workflow" : "${var.name}-workflow"
      }
    }
  ])
}

#WorkflowRole links a role to a workflow. The linked roles indicate which roles a user must be a part of to request access to a resource via the workflow.
resource "sdm_workflow_role" "this" {
    workflow_id = sdm_workflow.this.id
    role_id     = sdm_role.admins.id
}
