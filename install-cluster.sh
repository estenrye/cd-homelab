#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`
set -e

PROJECT='default'
POSITIONAL_ARGUMENTS=()

while [ ! $# -eq 0 ]; do
  case "$1" in
    --project) PROJECT=$2; shift;;
    *) POSITIONAL_ARGUMENTS[${#POSITIONAL_ARGUMENTS[@]}]="$1";;
  esac
  shift
done

set -- ${POSITIONAL_ARGUMENTS[@]}
if [ $# -ne 2 ]; then
  exit 1
fi
DEST_SERVER=$1
DNS_SUFFIX=$2

${SCRIPT_DIR}/ingress-nginx/deploy.sh ${DEST_SERVER} --project ${PROJECT} --external-dns-hostname nginx.${DNS_SUFFIX}
${SCRIPT_DIR}/cert-manager/deploy.sh ${DEST_SERVER} --project ${PROJECT} 
${SCRIPT_DIR}/sealed-secrets/deploy.sh ${DEST_SERVER} --project ${PROJECT} --external-dns-hostname sealed-secrets.${DNS_SUFFIX}


