resource null_resource install_tiller {
  count = "${var.enable_helm_tiller ? 1 : 0}"

  triggers {
    kubernetes_cluster = "${google_container_cluster.main.endpoint}"
  }

  provisioner local-exec {
    command     = "${file("${path.module}/scripts/apply_tiller.sh")}"
    working_dir = "${path.module}/scripts"

    environment {
      CLUSTER_NAME  = "${var.cluster_name}"
      GCLOUD_REGION = "${var.region}"
      PROJECT_ID    = "${var.project}"
    }
  }

  provisioner local-exec {
    command     = "${file("${path.module}/scripts/destroy_tiller.sh")}"
    when        = "destroy"
    working_dir = "${path.module}/scripts"

    environment {
      CLUSTER_NAME  = "${var.cluster_name}"
      GCLOUD_REGION = "${var.region}"
      PROJECT_ID    = "${var.project}"
    }
  }
}
