#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

PROJECT='default'

if [ $# -ne 1 ]; then
  echo "No cluster name provided."
  exit 1
fi

APP_NAME=$1
DEST_SERVER=`jq -r ".[\"${APP_NAME}\"].dest_server" ${SCRIPT_DIR}/clusters.json`
PROJECT=`jq -r ".[\"${APP_NAME}\"].project" ${SCRIPT_DIR}/clusters.json`

argocd app create cluster-${APP_NAME} \
  --project ${PROJECT} \
  --repo git@github.com:estenrye/cd-homelab.git \
  --path clusters/overlays/${APP_NAME} \
  --dest-server "${DEST_SERVER}" \
  --upsert
