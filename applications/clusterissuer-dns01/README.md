# CertManager ClusterIssuer for DNS01

## Description

This chart deploys a ClusterIssuer for CertManager to use DNS01 challenge. It uses the [cert-manager](https://cert-manager.io/) project.

## Prerequisites
- A Kubernetes cluster
- Helm 3
- A Cloudflare account
- A domain name

## Deploying the ClusterIssuer

```bash
helm repo add cert-manager https://charts.jetstack.io
helm repo update
helm upgrade --install cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --set installCRDs=true \
  --set global.leaderElection.namespace=cert-manager \
  cert-manager/cert-manager

ACME_EMAIL=email@example.com
DNS_ZONE=example.com
ITEM_PATH=vaults/vault/items/cert-manager.clusterissuer-dns01.example.com

# Provision ClusterIssuer for Cloudflare
helm upgrade --install clusterissuer-dns01 \
  --namespace cert-manager \
  --create-namespace \
  --set credentials.cloudflare.enabled=true \
  --set credentials.route53.enabled=false \
  --set credentials.cloudflare.itemPath=${ITEM_PATH} \
  --set acme.email=${ACME_EMAIL} \
  --set dns_zones_0=${DNS_ZONE} \
  ${HOME}/src/cd-homelab/applications/clusterissuer-dns01
```
