terraform {
  required_providers {
    sdm = {
      source = "strongdm/sdm"
      version = ">= 14.20.0"
    }
  }
}
resource "sdm_resource" "web_page" {
  http_no_auth {
    name             = "${var.name}-http"
    url              = "http://${aws_instance.web_page.private_ip}"
    default_path     = "/"
    healthcheck_path = "/"
    subdomain        = "${var.name}-web-page"

    proxy_cluster_id = var.proxy_cluster_id

    tags = merge({ Name = "${var.name}-http" }, var.tags)
  }
}

resource "sdm_resource" "ssh_ec2" {
  ssh_cert {
    name     = "${var.name}-ssh"
    username = "ec2-user"
    hostname = aws_instance.web_page.private_ip
    port     = 22
    tags     = merge({ Name = "${var.name}-ssh" }, var.tags)

    proxy_cluster_id = var.proxy_cluster_id
  }
}