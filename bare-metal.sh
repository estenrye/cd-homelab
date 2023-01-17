#!/bin/bash
SCRIPT_DIR=`cd "$(dirname $0)" && pwd`

kubectl apply -k ${SCRIPT_DIR}/applications/argocd
kubectl apply -k ${SCRIPT_DIR}/applications/metallb

# TODO: op cli commands to retrieve 1password connect file and token
# TODO: helm repo add for 1password connect
# TODO: helm install for 1password connect

kubectl apply -k ${SCRIPT_DIR}/applications/clusterinfo/overlays/k8s-bare-metal.usmnblm01.rye.ninja