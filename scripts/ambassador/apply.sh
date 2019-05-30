#!/usr/bin/env sh

set -xeuo pipefail

source ../wait_cluster.sh
source ../kubectl_auth.sh

AMBASSADOR_VERSION=${AMBASSADOR_VERSION:='0.40.2'}
ambassador_image="quay.io/datawire/ambassador:$AMBASSADOR_VERSION"

kubectl delete --ignore-not-found=true clusterrolebinding tmp-ambassador-install-role-binding

kubectl create clusterrolebinding tmp-ambassador-install-role-binding \
	--clusterrole=cluster-admin \
	--user=$(gcloud info --format="value(config.account)")

cat ./ambassador.yml \
  | sed -e "s,__AMBASSADOR_IMAGE__,$ambassador_image,g" \
  | kubectl apply -f -

kubectl delete clusterrolebinding tmp-ambassador-install-role-binding
