variable ambassador_version {
  default     = "0.40.2"
  description = "Ambassador version to install when enable_ambassador = true"
}

variable ambassador_load_balancer_ip {
  default     = ""
  description = "Static IP to assign to the LoadBalancer created for Ambassador"
}

variable cluster_name {
  description = "Google Kubernetes Engine cluster name"
}

variable enable_ambassador {
  default     = false
  description = "Installs Ambassador API Gateway"
}

variable enable_helm_tiller {
  default     = false
  description = "Installs Helm Tiller"
}

variable enable_istio_addon {
  default     = false
  description = "Enable Istio (service mesh) addon"
}

variable istio_config_mtls {
  default     = "MTLS_PERMISSIVE"
  description = "Istio multual tls configuration. Possible values are MTLS_STRICT or MTLS_PERMISSIVE"
}

variable daily_maintenance_window {
  default     = "03:00"
  description = "Cluster maintenance window"
}

variable enable_horizontal_pod_autoscaling_addon {
  default     = true
  description = "Enable Kubernetes HPA addon"
}

variable enable_http_load_balancing_addon {
  default     = true
  description = "Enable GCP Load balancer addon"
}

variable kubernetes_version {
  default     = "latest"
  description = "Kubernetes version. Possible values are latest or a specific version"
}

variable logging_service {
  default     = "logging.googleapis.com"
  description = "Stackdriver logging service name. Possible values are logging.googleapis.com or logging.googleapis.com/kubernetes (beta)"
}

variable master_authorized_networks_config {
  default = [{
    cidr_block   = "0.0.0.0/0"
    display_name = "Allow all"
  }]

  description = "Master authorized networks config. Docs: https://www.terraform.io/docs/providers/google/r/container_cluster.html#master_authorized_networks_config"
}

variable master_ipv4_cidr_block {
  default     = "192.168.0.0/28"
  description = "Master CIDR block. This range should not overlap any other ranges in the cluster network"
}

variable monitoring_service {
  default     = "monitoring.googleapis.com"
  description = "Stackdriver logging service name. Possible values are monitoring.googleapis.com or monitoring.googleapis.com/kubernetes (beta)"
}

variable network {
  description = "Network to which the cluster is connected"
}

variable node_pools {
  default     = []
  description = "List of node pools. Attributes: name (required), min_node_count, max_node_count, disk_type, disk_size, machine_type, preemptible, service_account"
}

variable pods_secondary_ip_range_name {
  description = "Secondary ip range will be used for Pods IPs"
}

variable project {
  default     = ""
  description = "GCP ProjectId"
}

variable region {
  description = "Region to create the cluster"
}

variable services_secondary_ip_range_name {
  description = "Secondary ip range will be used for Services IPs"
}

variable subnetwork {
  description = "Subnetwork to which the cluster is connected"
}

variable nodes_locations {
  default     = []
  description = "Zones that the cluster nodes will run"
}
