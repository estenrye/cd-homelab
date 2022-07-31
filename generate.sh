#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

PROJECT='default'

if [ $# -ne 1 ]; then
  echo "No cluster name provided."
  exit 1
fi

CONFIG="${SCRIPT_DIR}/clusters.yaml"

APP_NAME=`yq ".${1}.app_name" ${CONFIG}`

mkdir -p clusters/overlays/${APP_NAME}
COOKIECUTTER_REPLAY='{
  "cookiecutter": {
    "project_name": .CLUSTER_NAME.app_name,
    "project_slug": .CLUSTER_NAME.app_name,
    "config": .CLUSTER_NAME
  },
  "_template": "SCRIPT_DIR/.cookiecutters/overlays/clusters/",
  "_output_dir": "SCRIPT_DIR/clusters/overlays"
}'
COOKIECUTTER_REPLAY=`echo ${COOKIECUTTER_REPLAY} | sed "s|CLUSTER_NAME|${1}|g" | sed "s|SCRIPT_DIR|${SCRIPT_DIR}|g"`
yq "${COOKIECUTTER_REPLAY}" clusters.yaml -o json > clusters/overlays/${APP_NAME}/cookiecutter.json
cookiecutter \
  --replay \
  --replay-file clusters/overlays/${APP_NAME}/cookiecutter.json \
  --overwrite-if-exists \
  --verbose \
  --output-dir ${SCRIPT_DIR}/clusters/overlays \
  ${SCRIPT_DIR}/.cookiecutters/overlays/clusters