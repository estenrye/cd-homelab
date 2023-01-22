#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

# TODO: op cli commands to retrieve 1password connect file and token
cat 1password-credentials.json | base64 | \
  tr '/+' '_-' | tr -d '=' | tr -d '\n' > op-session

# Deploy 1password secrets
kubectl create ns 1password
kubectl create -n 1password secret generic op-credentials --from-file=op-session
kubectl create -n 1password secret generic onepassword-token --from-literal=token="<OP_CONNECT_TOKEN>"

kubectl apply -k ${SCRIPT_DIR}/applications/argocd
kubectl apply -f ${SCRIPT_DIR}/argocd/apps/argocd-projects.yaml
kubectl apply -f ${SCRIPT_DIR}/argocd/apps/argocd-apps.yaml

# TODO: helm repo add for 1password connect
# TODO: helm install for 1password connect

