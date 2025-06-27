resource "sdm_node" "proxy-cluster" {
  proxy_cluster {
    name    = "${var.name}-proxy-cluster"
    address = "${var.nlb_address}:443"
    tags = {
      owner = var.name
    }
  }
}

resource "sdm_proxy_cluster_key" "this" {
  proxy_cluster_id = sdm_node.proxy-cluster.id
}