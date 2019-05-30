resource null_resource install_ambassador {
  count = "${var.enable_ambassador ? 1 : 0}"

  triggers {
    ambassador_version = "${var.ambassador_version}"
    kubernetes_cluster = "${google_container_cluster.main.endpoint}"
  }

  provisioner local-exec {
    command     = "${file("${path.module}/scripts/ambassador/apply.sh")}"
    working_dir = "${path.module}/scripts/ambassador"

    environment {
      AMBASSADOR_VERSION = "${var.ambassador_version}"
      CLUSTER_NAME       = "${var.cluster_name}"
      GCLOUD_REGION      = "${var.region}"
      PROJECT_ID         = "${var.project}"
    }
  }

  provisioner local-exec {
    command     = "${file("${path.module}/scripts/ambassador/destroy.sh")}"
    when        = "destroy"
    working_dir = "${path.module}/scripts/ambassador"

    environment {
      CLUSTER_NAME  = "${var.cluster_name}"
      GCLOUD_REGION = "${var.region}"
      PROJECT_ID    = "${var.project}"
    }
  }
}

resource null_resource install_ambassador_load_balancer {
  count = "${var.enable_ambassador ? 1 : 0}"

  triggers {
    load_balancer_ip = "${var.ambassador_load_balancer_ip}"
  }

  provisioner local-exec {
    command     = "${file("${path.module}/scripts/ambassador/apply_load_balancer.sh")}"
    working_dir = "${path.module}/scripts/ambassador"

    environment {
      LOAD_BALANCER_IP = "${var.ambassador_load_balancer_ip}"
      CLUSTER_NAME     = "${var.cluster_name}"
      GCLOUD_REGION    = "${var.region}"
      PROJECT_ID       = "${var.project}"
    }
  }

  provisioner local-exec {
    command     = "${file("${path.module}/scripts/ambassador/destroy_load_balancer.sh")}"
    when        = "destroy"
    working_dir = "${path.module}/scripts/ambassador"

    environment {
      CLUSTER_NAME  = "${var.cluster_name}"
      GCLOUD_REGION = "${var.region}"
      PROJECT_ID    = "${var.project}"
    }
  }

  depends_on = ["null_resource.install_ambassador"]
}
