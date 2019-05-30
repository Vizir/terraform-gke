locals {
  kubernetes_version = "${var.kubernetes_version != "latest" ? var.kubernetes_version : data.google_container_engine_versions.region.latest_node_version}"
  nodes_network_tag  = "gke-node-${var.cluster_name}-network-tag"

  nodes_locations = "${
    length(var.nodes_locations) > 0
    ? join(",", var.nodes_locations)
    : join(",", data.google_compute_zones.available.names)
  }"

  project = "${var.project == "" ? data.google_project.default.project_id : var.project}"
}

data google_project default {}

data google_compute_zones available {
  project = "${local.project}"
  region  = "${var.region}"
}

data google_container_engine_versions region {
  project  = "${local.project}"
  location = "${data.google_compute_zones.available.names[0]}"
}

resource google_container_cluster main {
  provider                    = "google-beta"
  enable_binary_authorization = true
  initial_node_count          = 1
  location                    = "${var.region}"
  logging_service             = "${var.logging_service}"
  min_master_version          = "${local.kubernetes_version}"
  monitoring_service          = "${var.monitoring_service}"
  name                        = "${var.cluster_name}"
  network                     = "${var.network}"
  node_locations              = ["${split(",", local.nodes_locations)}"]
  project                     = "${local.project}"
  remove_default_node_pool    = true
  subnetwork                  = "${var.subnetwork}"

  addons_config {
    horizontal_pod_autoscaling {
      disabled = "${!var.enable_horizontal_pod_autoscaling_addon}"
    }

    http_load_balancing {
      disabled = "${!var.enable_http_load_balancing_addon}"
    }

    kubernetes_dashboard {
      # GKE Dashboard is deprecated
      disabled = true
    }
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "${var.pods_secondary_ip_range_name}"
    services_secondary_range_name = "${var.services_secondary_ip_range_name}"
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "${var.daily_maintenance_window}"
    }
  }

  master_auth {
    # This is the *obvious* required configuration block to disable basic auth
    password = ""
    username = ""

    client_certificate_config = {
      issue_client_certificate = false
    }
  }

  master_authorized_networks_config {
    cidr_blocks = "${var.master_authorized_networks_config}"
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  private_cluster_config {
    enable_private_endpoint = false
    enable_private_nodes    = true
    master_ipv4_cidr_block  = "${var.master_ipv4_cidr_block}"
  }

  timeouts {
    create = "30m"
    delete = "30m"
    update = "30m"
  }
}

resource google_container_node_pool main {
  count              = "${length(var.node_pools)}"
  cluster            = "${google_container_cluster.main.name}"
  initial_node_count = "${lookup(var.node_pools[count.index], "min_node_count", 1)}"
  location           = "${var.region}"
  name               = "${lookup(var.node_pools[count.index], "name")}"
  project            = "${local.project}"

  autoscaling {
    max_node_count = "${lookup(var.node_pools[count.index], "max_node_count", 10)}"
    min_node_count = "${lookup(var.node_pools[count.index], "min_node_count", 1)}"
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    disk_size_gb    = "${lookup(var.node_pools[count.index], "disk_size", 40)}"
    disk_type       = "${lookup(var.node_pools[count.index], "disk_type", "pd-standard")}"
    machine_type    = "${lookup(var.node_pools[count.index], "machine_type", "g1-small")}"
    preemptible     = "${lookup(var.node_pools[count.index], "preemptible", false)}"
    service_account = "${lookup(var.node_pools[count.index], "service_account", "")}"

    metadata {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    tags = ["${local.nodes_network_tag}"]
  }

  lifecycle {
    ignore_changes = ["initial_node_count"]
  }
}
