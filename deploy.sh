#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

PROJECT='default'

if [ $# -ne 1 ]; then
  echo "No cluster name provided."
  exit 1
fi

CONFIG="${SCRIPT_DIR}/clusters.yaml"

APP_NAME=`yq ".${1}.app_name" ${CONFIG}`
DEST_SERVER=`yq ".${1}.dest_server" ${CONFIG}`
PROJECT=`yq ".${1}.project" ${CONFIG}`

argocd app create ${APP_NAME} \
  --project ${PROJECT} \
  --repo git@github.com:estenrye/cd-homelab.git \
  --path clusters/overlays/${APP_NAME} \
  --dest-server "${DEST_SERVER}" \
  --upsert
