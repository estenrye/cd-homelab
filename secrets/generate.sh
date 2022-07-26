#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

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
if [ $# -ne 0 ]; then
  exit 1
fi

PLAINTEXT_FILE=$(mktemp)
CIPHERTEXT_FILE=$(mktemp)

trap 'rm -f "${PLAINTEXT_FILE}" "${CIPHERTEXT_FILE}"' EXIT

mkdir -p "${SCRIPT_DIR}/${PROJECT}"

########

kubectl create namespace cert-manager --dry-run=client -o yaml > ${PLAINTEXT_FILE}
kubectl neat -f ${PLAINTEXT_FILE} -o yaml > "${SCRIPT_DIR}/${PROJECT}/cert-manager_namespace.yaml"

kubectl create secret generic \
  cloudflare-api-token \
  --namespace cert-manager \
  --from-literal=qpi-token=${CLOUDFLARE_API_TOKEN} \
  --dry-run=client \
  -o yaml > ${PLAINTEXT_FILE}

kubeseal --cert http://sealed-secrets.services.dialtone.rye.ninja/v1/cert.pem -o yaml < ${PLAINTEXT_FILE} > ${CIPHERTEXT_FILE}

kubectl neat -f ${CIPHERTEXT_FILE} > "${SCRIPT_DIR}/${PROJECT}/cert-manager_cloudflare-api-token.yaml"

########

kubectl create namespace external-dns --dry-run=client -o yaml > ${PLAINTEXT_FILE}

kubectl neat -f ${PLAINTEXT_FILE} -o yaml > "${SCRIPT_DIR}/${PROJECT}/external-dns_namespace.yaml"

kubectl create secret generic \
  cloudflare-api-token \
  --namespace external-dns \
  --from-literal=qpi-token=${CLOUDFLARE_API_TOKEN} \
  --dry-run=client \
  -o yaml > ${PLAINTEXT_FILE}

kubeseal --cert http://sealed-secrets.services.dialtone.rye.ninja/v1/cert.pem -o yaml < ${PLAINTEXT_FILE} > ${CIPHERTEXT_FILE}

kubectl neat -f ${CIPHERTEXT_FILE} > "${SCRIPT_DIR}/${PROJECT}/external-dns_cloudflare-api-token.yaml"

########