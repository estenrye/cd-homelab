# Istio

## Installation

```bash
kubectl create namespace istio-system
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
helm upgrade --install istio-base istio/base \
  --create-namespace \
  --namespace istio-system \
  --values ${HOME}/src/cd-homelab/applications/istio/base.values.yaml
helm upgrade --install istiod istio/istiod --wait \
  --create-namespace \
  --namespace istio-system \
  --values ${HOME}/src/cd-homelab/applications/istio/istiod.values.yaml
