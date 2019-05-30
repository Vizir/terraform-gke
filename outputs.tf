output cluster_endpoint {
  value       = "${google_container_cluster.main.endpoint}"
  description = "Cluster endpoint ip"
}

output cluster_name {
  value       = "${var.cluster_name}"
  description = "Cluster name"
}

output master_auth_cluster_ca_certificate {
  value       = "${google_container_cluster.main.master_auth.0.cluster_ca_certificate}"
  description = "Master CA certificate"
}

output nodes_network_tag {
  value       = "${local.nodes_network_tag}"
  description = "Network tag that will be applied to every node"
}
