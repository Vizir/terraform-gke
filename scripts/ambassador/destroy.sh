#!/usr/bin/env sh

set -xeuo pipefail

source ../wait_cluster.sh
source ../kubectl_auth.sh

kubectl delete --ignore-not-found=true -f ./ambassador.yml
