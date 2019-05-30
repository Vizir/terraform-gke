# Kubernetes module

Setup a regional kubernetes cluster on Google Kubernetes Engine.

## Requirements

- This module uses Terraform 0.11.X
- To enable `istio` you must install:
  - [gcloud](https://cloud.google.com/sdk/install)
- To enable `ambassador` you must install:
  - [gcloud](https://cloud.google.com/sdk/install)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- To enable `helm` you must install:
  - [gcloud](https://cloud.google.com/sdk/install)
  - [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
  - [helm](https://helm.sh/docs/using_helm/)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ambassador\_load\_balancer\_ip | Static IP to assign to the LoadBalancer created for Ambassador | string | `""` | no |
| ambassador\_version | Ambassador version to install when enable_ambassador = true | string | `"0.40.2"` | no |
| cluster\_name | Google Kubernetes Engine cluster name | string | n/a | yes |
| daily\_maintenance\_window | Cluster maintenance window | string | `"03:00"` | no |
| enable\_ambassador | Installs Ambassador API Gateway | string | `"false"` | no |
| enable\_helm\_tiller | Installs Helm Tiller | string | `"false"` | no |
| enable\_horizontal\_pod\_autoscaling\_addon | Enable Kubernetes HPA addon | string | `"true"` | no |
| enable\_http\_load\_balancing\_addon | Enable GCP Load balancer addon | string | `"true"` | no |
| enable\_istio\_addon | Enable Istio (service mesh) addon | string | `"false"` | no |
| istio\_config\_mtls | Istio multual tls configuration. Possible values are MTLS_STRICT or MTLS_PERMISSIVE | string | `"MTLS_PERMISSIVE"` | no |
| kubernetes\_version | Kubernetes version. Possible values are latest or a specific version | string | `"latest"` | no |
| logging\_service | Stackdriver logging service name. Possible values are logging.googleapis.com or logging.googleapis.com/kubernetes (beta) | string | `"logging.googleapis.com"` | no |
| master\_authorized\_networks\_config | Master authorized networks config. Docs: https://www.terraform.io/docs/providers/google/r/container_cluster.html#master_authorized_networks_config | list | `<list>` | no |
| master\_ipv4\_cidr\_block | Master CIDR block. This range should not overlap any other ranges in the cluster network | string | `"192.168.0.0/28"` | no |
| monitoring\_service | Stackdriver logging service name. Possible values are monitoring.googleapis.com or monitoring.googleapis.com/kubernetes (beta) | string | `"monitoring.googleapis.com"` | no |
| network | Network to which the cluster is connected | string | n/a | yes |
| node\_pools | List of node pools. Attributes: name (required), min_node_count, max_node_count, disk_type, disk_size, machine_type, preemptible, service_account | list | `<list>` | no |
| nodes\_locations | Zones that the cluster nodes will run | list | `<list>` | no |
| pods\_secondary\_ip\_range\_name | Secondary ip range will be used for Pods IPs | string | n/a | yes |
| project | GCP ProjectId | string | `""` | no |
| region | Region to create the cluster | string | n/a | yes |
| services\_secondary\_ip\_range\_name | Secondary ip range will be used for Services IPs | string | n/a | yes |
| subnetwork | Subnetwork to which the cluster is connected | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_endpoint | Cluster endpoint ip |
| cluster\_name | Cluster name |
| master\_auth\_cluster\_ca\_certificate | Master CA certificate |
| nodes\_network\_tag | Network tag that will be applied to every node |

