#!/usr/bin/env sh

gcloud container clusters get-credentials \
  $CLUSTER_NAME \
  --project=$PROJECT_ID \
  --region=$GCLOUD_REGION
