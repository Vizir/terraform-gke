#!/usr/bin/env sh

set -xeuo pipefail

source ./wait_cluster.sh
source ./kubectl_auth.sh

cat ./tiller_service_account.yml | kubectl create -f -

helm init --service-account tiller
helm repo update
