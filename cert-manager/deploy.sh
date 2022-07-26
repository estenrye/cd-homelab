#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

APP_NAME='cert-manager'
NAMESPACE='cert-manager'
REVISION='v1.8.2'
PROJECT='default'
POSITIONAL_ARGUMENTS=()

while [ ! $# -eq 0 ]; do
  case "$1" in
    --app-name) APP_NAME=$2; shift;;
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
  --repo https://charts.jetstack.io \
  --helm-chart cert-manager \
  --revision "${REVISION}" \
  --dest-namespace "${NAMESPACE}" \
  --dest-server "${DEST_SERVER}" \
  --values-literal-file ${SCRIPT_DIR}/values.yaml \
  --sync-option CreateNamespace=true