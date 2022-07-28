#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

NAMESPACE='base'
REVISION='0.1.2'
PROJECT='default'
SVC_LOAD_BALANCER_IP=''

POSITIONAL_ARGUMENTS=()

while [ ! $# -eq 0 ]; do
  case "$1" in
    --app-name) APP_NAME=$2; shift;;
    --namespace) NAMESPACE=$2; shift;;
    --project) PROJECT=$2; shift;;
    --revision) REVISION=$2; shift;;
    --ingress-nginx-load-balancer-ip) SVC_LOAD_BALANCER_IP=$2; shift;;
    --top-level-domain) TOP_LEVEL_DOMAIN=$2; shift;;
    *) POSITIONAL_ARGUMENTS[${#POSITIONAL_ARGUMENTS[@]}]="$1";;
  esac
  shift
done

set -- ${POSITIONAL_ARGUMENTS[@]}
if [ $# -ne 1 ]; then
  echo "No destination server provided."
  exit 1
fi

if [ -z "${APP_NAME}" ]; then
  echo "No app-name provided."
  exit 1
fi

if [ -z "${TOP_LEVEL_DOMAIN}" ]; then
  echo "No top-level-domain provided."
fi

DEST_SERVER=$1

argocd app create cluster-config-${APP_NAME} \
  --project ${PROJECT} \
  --repo https://estenrye.github.io/helm-charts \
  --helm-chart cluster_base_config \
  --revision "${REVISION}" \
  --dest-namespace "${NAMESPACE}" \
  --dest-server "${DEST_SERVER}" \
  --helm-set ingress_nginx_load_balancer_ip="${SVC_LOAD_BALANCER_IP}" \
  --helm-set top_level_domain="${TOP_LEVEL_DOMAIN}" \
  --helm-set cluster_name="${APP_NAME}" \
  --sync-option CreateNamespace=true \
  --upsert
