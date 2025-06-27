terraform {
  required_providers {
    sdm = {
      source = "strongdm/sdm"
      version = ">= 14.20.0"
    }
  }
}

resource "sdm_resource" "windows_server" {
  rdp {
    name     = "${var.name}-rdp"
    hostname = local.hostname
    port     = 3389
    username = "Administrator"
    password = rsadecrypt(local.password, local.private_key)
    tags     = merge({ Name = "${var.name}-rdp" }, var.tags)

    proxy_cluster_id = var.proxy_cluster_id
  }
}