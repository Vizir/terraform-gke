#!/usr/bin/env sh

set -xeuo pipefail

source ./wait_cluster.sh
source ./kubectl_auth.sh

kubectl delete deployment tiller-deploy --namespace kube-system

cat ./tiller_service_account.yml | kubectl delete -f -
