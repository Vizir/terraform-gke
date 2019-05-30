#!/usr/bin/env sh

set -xeuo pipefail

source ./wait_cluster.sh

gcloud -q beta container clusters update $CLUSTER_NAME \
  --project=$PROJECT_ID \
  --region=$GCLOUD_REGION \
  --update-addons=Istio=DISABLED
