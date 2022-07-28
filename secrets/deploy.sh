#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

APP_NAME='secrets'
PROJECT='default'
EXTERNAL_DNS_HOSTNAME=''
POSITIONAL_ARGUMENTS=()

while [ ! $# -eq 0 ]; do
  case "$1" in
    --app-name) APP_NAME=$2; shift;;
    --project) PROJECT=$2; shift;;
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
  --repo git@github.com:estenrye/cd-homelab.git \
  --path secrets/${PROJECT} \
  --dest-server "${DEST_SERVER}"
