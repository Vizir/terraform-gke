resource null_resource enable_istio_addon {
  count = "${var.enable_istio_addon ? 1 : 0}"

  triggers {
    kubernetes_cluster = "${google_container_cluster.main.endpoint}"
    istio_config_mtls  = "${var.istio_config_mtls}"
  }

  provisioner local-exec {
    command     = "${file("${path.module}/scripts/apply_istio.sh")}"
    working_dir = "${path.module}/scripts"

    environment {
      CLUSTER_NAME      = "${var.cluster_name}"
      GCLOUD_REGION     = "${var.region}"
      ISTIO_CONFIG_MTLS = "${var.istio_config_mtls}"
      PROJECT_ID        = "${var.project}"
    }
  }

  provisioner local-exec {
    command     = "${file("${path.module}/scripts/destroy_istio.sh")}"
    when        = "destroy"
    working_dir = "${path.module}/scripts"

    environment {
      CLUSTER_NAME  = "${var.cluster_name}"
      GCLOUD_REGION = "${var.region}"
      PROJECT_ID    = "${var.project}"
    }
  }
}
