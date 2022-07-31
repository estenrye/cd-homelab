#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

APP_NAME='sealed-secrets'
NAMESPACE='sealed-secrets'
REVISION='2.4.0'
PROJECT='default'
EXTERNAL_DNS_HOSTNAME=''
POSITIONAL_ARGUMENTS=()

while [ ! $# -eq 0 ]; do
  case "$1" in
    --app-name) APP_NAME=$2; shift;;
    --external-dns-hostname) EXTERNAL_DNS_HOSTNAME=$2; shift;;
    --namespace) NAMESPACE=$2; shift;;
    --project) PROJECT=$2; shift;;
    --revision) REVISION=$2; shift;;
    *) POSITIONAL_ARGUMENTS[${#POSITIONAL_ARGUMENTS[@]}]="$1";;
  esac
  shift
done

set -- ${POSITIONAL_ARGUMENTS[@]}
if [ $# -ne 1 ]; then
  exit 1
fi
DEST_SERVER=$1

argocd app create ${PROJECT}-${APP_NAME} \
  --project ${PROJECT} \
  --repo https://bitnami-labs.github.io/sealed-secrets \
  --helm-chart sealed-secrets \
  --revision "${REVISION}" \
  --dest-namespace "${NAMESPACE}" \
  --dest-server "${DEST_SERVER}" \
  --helm-set ingress.annotations."external-dns\.alpha\.kubernetes\.io/hostname"="${EXTERNAL_DNS_HOSTNAME}." \
  --helm-set ingress.hostname="${EXTERNAL_DNS_HOSTNAME}" \
  --values-literal-file ${SCRIPT_DIR}/values.yaml \
  --sync-option CreateNamespace=true
