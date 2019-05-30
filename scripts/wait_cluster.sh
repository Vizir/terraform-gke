#!/usr/bin/env sh

cluster_status=''

while [ "$cluster_status" != 'RUNNING' ]; do
  echo 'Waiting cluster to reach "RUNNING" status...'
  sleep 5
  cluster_status=$(gcloud container clusters \
    describe $CLUSTER_NAME \
    --region $GCLOUD_REGION \
    --format 'get(status)')
done
