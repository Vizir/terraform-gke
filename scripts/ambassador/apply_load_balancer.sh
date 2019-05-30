#!/usr/bin/env sh

set -xeuo pipefail

source ../wait_cluster.sh
source ../kubectl_auth.sh

LOAD_BALANCER_IP=${LOAD_BALANCER_IP:=''}

cat ./load_balancer.yml \
  | sed -e "s,__LOAD_BALANCER_IP__,$LOAD_BALANCER_IP,g" \
  | kubectl apply -f -
