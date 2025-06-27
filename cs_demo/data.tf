# ---------------------------------------------------------------------------- #
# Grab the strongDM CA public key for the authenticated organization
# ---------------------------------------------------------------------------- #
data "sdm_ssh_ca_pubkey" "this_key" {}

# data "sdm_account" "existing_users" {
#   count = length(var.grant_to_existing_users)
#   type  = "user"
#   email = var.grant_to_existing_users[count.index]
# }