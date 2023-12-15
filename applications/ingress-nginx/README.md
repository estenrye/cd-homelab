# Ingress Nginx

## Introduction

Ingress Nginx is an Ingress Controller for Kubernetes. It is used to expose services to the Internet.
It is configured via Ingress Resources.

## Prerequisites

- A Kubernetes cluster
- Helm 3

## Deploying Ingress Nginx

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Provision Ingress Nginx for cloudflared
helm upgrade --install ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  ingress-nginx/ingress-nginx \
  --values ${HOME}/src/cd-homelab/applications/ingress-nginx/values.yaml \
  --values ${HOME}/src/cd-homelab/applications/ingress-nginx/values.cloudflared.yaml

# Provision Ingress Nginx for EKS using NLB
helm upgrade --install ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  ingress-nginx/ingress-nginx \
  --values ${HOME}/src/cd-homelab/applications/ingress-nginx/values.yaml \
  --values ${HOME}/src/cd-homelab/applications/ingress-nginx/values.eks.yaml

# Provision Ingress Nginx for K3s using MetalLB
helm upgrade --install ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  ingress-nginx/ingress-nginx \
  --values ${HOME}/src/cd-homelab/applications/ingress-nginx/values.yaml \
  --values ${HOME}/src/cd-homelab/applications/ingress-nginx/values.k3s.yaml
```