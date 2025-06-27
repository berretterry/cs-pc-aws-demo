terraform {
  required_providers {
    sdm = {
      source = "strongdm/sdm"
      version = ">= 14.20.0"
    }
  }
}

resource "sdm_resource" "mysql_admin" {
  mysql {
    name     = "${var.name}-mysql-admin"
    hostname = local.hostname
    database = local.database
    username = local.username
    password = local.password
    port     = 3306

    proxy_cluster_id = var.proxy_cluster_id

    tags = merge({ Name = "${var.name}-mysql-admin" }, var.tags)
  }
}
resource "sdm_resource" "mysql_ro" {
  mysql {
    name     = "${var.name}-mysql-replica-read-only"
    hostname = local.hostname
    database = local.database
    username = local.username
    password = local.password
    port     = 3306

    proxy_cluster_id = var.proxy_cluster_id

    tags = merge({
      Name               = "${var.name}-mysql-ro",
      ReadOnlyOnboarding = "true"
    }, var.tags)
  }
}