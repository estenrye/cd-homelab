#!/bin/bash

if [ $# -ne 1 ]; then
  echo "No cluster name provided."
  exit 1
fi

SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

CONFIG_FILE="${SCRIPT_DIR}/op-cli.yaml"
APP_NAME=`yq ".${1}.app_name" ${SCRIPT_DIR}/clusters.yaml`

OP_ACCOUNT=`yq '.account' ${CONFIG_FILE}`
OP_VAULT=`yq '.vault' ${CONFIG_FILE}`
CF_API_PREFIX=`yq '.secret_name_prefixes.cloudflare_api_token' ${CONFIG_FILE}`
KUBECONFIG_FILE=`yq ".${1}.kube_config" ${SCRIPT_DIR}/clusters.yaml`
KUBECONFIG_FILE=`echo ${KUBECONFIG_FILE} | sed "s|^~|${HOME}|"`

CLOUDFLARE_API_TOKEN=`op item get ${CF_API_PREFIX}${1} --account ${OP_ACCOUNT} --vault ${OP_VAULT} --fields password`
CLOUDFLARE_ZONE_ID=`op item get ${CF_API_PREFIX}${1} --account ${OP_ACCOUNT} --vault ${OP_VAULT} --fields zone_id`
SEALED_SECRETS_IP=`kubectl get --kubeconfig=${KUBECONFIG_FILE} -n sealed-secrets ingress sealed-secrets-controller -o jsonpath='{.status.loadBalancer.ingress[0].ip}'`
SEALED_SECRETS_NAME=`kubectl get --kubeconfig=${KUBECONFIG_FILE} -n sealed-secrets ingress sealed-secrets-controller -o jsonpath='{.spec.rules[0].host}'`

curl -X POST "https://api.cloudflare.com/client/v4/zones/${CLOUDFLARE_ZONE_ID}/dns_records/" \
    -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
    -H "Content-Type: application/json" \
    --data "{\"type\":\"A\",\"name\":\"${SEALED_SECRETS_NAME}\",\"content\":\"${SEALED_SECRETS_IP}\",\"proxied\":false,\"ttl\":\"120\"}" | jq

CLOUDFLARE_API_TOKEN=`echo -n ${CLOUDFLARE_API_TOKEN} | base64 -b 0`
mkdir -p secrets/overlays/${APP_NAME}

JQ_QUERY="{
  \"cookiecutter\": .,
  \"_template\": \"${SCRIPT_DIR}/.cookiecutters/overlays/secrets/\",
  \"_output_dir\": \"${SCRIPT_DIR}/secrets/overlays\" } |
  .cookiecutter.project_name = \"${APP_NAME}\" |
  .cookiecutter.project_slug = \"${APP_NAME}\" |
  .cookiecutter.cloudflare_api_token = \"${CLOUDFLARE_API_TOKEN}\""

jq "${JQ_QUERY}" .cookiecutters/overlays/secrets/cookiecutter.json > ${SCRIPT_DIR}/secrets/overlays/${APP_NAME}/cookiecutter.json

cookiecutter \
  --replay \
  --replay-file ${SCRIPT_DIR}/secrets/overlays/${APP_NAME}/cookiecutter.json \
  --overwrite-if-exists \
  --verbose \
  --output-dir ${SCRIPT_DIR}/secrets/overlays \
  ${SCRIPT_DIR}/.cookiecutters/overlays/secrets

kubeseal \
  --cert http://${SEALED_SECRETS_NAME}/v1/cert.pem \
  -o yaml \
  < secrets/overlays/${APP_NAME}/resources/cert-manager/cloudflare-api-token.yaml \
  > secrets/overlays/${APP_NAME}/resources/cert-manager/sealed-secret_cloudflare-api-token.yaml

kubeseal \
  --cert http://${SEALED_SECRETS_NAME}/v1/cert.pem \
  -o yaml \
  < secrets/overlays/${APP_NAME}/resources/external-dns/cloudflare-api-token.yaml \
  > secrets/overlays/${APP_NAME}/resources/external-dns/sealed-secret_cloudflare-api-token.yaml

rm -rf \
  ${SCRIPT_DIR}/secrets/overlays/${APP_NAME}/cookiecutter.json \
  ${SCRIPT_DIR}/secrets/overlays/${APP_NAME}/resources/cert-manager/cloudflare-api-token.yaml \
  ${SCRIPT_DIR}/secrets/overlays/${APP_NAME}/resources/external-dns/cloudflare-api-token.yaml