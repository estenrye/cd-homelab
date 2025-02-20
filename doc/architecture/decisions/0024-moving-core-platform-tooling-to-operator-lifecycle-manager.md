# 24. Moving Core Platform Tooling to Operator Lifecycle Manager

Date: 2025-02-14

## Status

Accepted

## Context

I want to reduce the overall maintenance of the core platform tooling. The current approach of using Helm charts for deployment and management of the core platform tooling is becoming increasingly complex and difficult to maintain. Additionally, the current approach does not provide a clear way to manage dependencies between different components of the core platform tooling.

## Decision

### Installing the Operator Lifecycle Manager

The Operator Lifecycle Manager (OLM) is a Kubernetes-native way to manage the lifecycle of operators. It provides a way to install, upgrade, and manage the lifecycle of operators in a Kubernetes cluster. OLM also provides a way to manage dependencies between different operators.  The first step of installing OLM is to install the Operator-SDK on your local machine.  Then you can use the Operator-SDK to install OLM on your Kubernetes cluster.

```bash
brew install operator-sdk

export KUBECONFIG=~/.kube/config
operator-sdk olm install
```

## Install Krew

```bash
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
```

## Install CLI Tools

```bash
brew install kubeseal
kubectl krew install cert-manager
kubectl krew install neat
kubectl krew install operator
```

## Deploy Software to argocd management cluster

```bash
# Deploy the Priority Classes
kubectl apply -k applications/priority-classes

# Deploy the Sealed Secrets controller
kustomize build --enable-helm applications/sealed-secrets | kubectl apply -f -

# Update the 1Password Operator Secrets in Source Control
kubectl create secret generic op-credentials -n 1password \
  --from-literal=1password-credentials.json=`op read --account ryefamily.1password.com op://Home_lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json | base64` \
  --dry-run=client -o yaml | kubeseal --controller-namespace=kubeseal --controller-name=sealed-secrets -o yaml \
  > overlays/in-cluster/1password/resources/sealed-secrets-credentials.yaml

kubectl create secret generic onepassword-token -n 1password \
  --from-literal=token=`op read --account ryefamily.1password.com op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential` \
  --dry-run=client -o yaml | kubeseal --controller-namespace=kubeseal --controller-name=sealed-secrets -o yaml \
  > overlays/in-cluster/1password/resources/sealed-secrets-token.yaml

# Deploy the 1Password Operator and Secrets Injector
kustomize build --enable-helm overlays/in-cluster/1password | kubectl apply -f -

# Deploy the Kube-Prometheus Stack
# Run Twice
kustomize build --enable-helm applications/kube-prometheus-stack | kubectl apply --server-side -f -

# Deploy Cert-Manager
kubectl apply -k applications/cert-manager

# Deploy Cluster Issuer
kubectl apply -k applications/zerossl-cluster-issuer

# Install the Gateway API
kubectl apply -k applications/gateway-api

# Install the HAProxy Ingress Controller
kustomize build --enable-helm applications/haproxy-ingress | kubectl apply -f -

# Deploy External DNS
kustomize build --enable-helm overlays/in-cluster/external-dns | kubectl apply -f -

# Deploy Argo CD
kustomize build --enable-helm overlays/argo-cluster/argocd | kubectl apply -f - 

# Deploy Argo Events
kustomize build --enable-helm applications/argo-events | kubectl apply -f -

# Deploy the Argo Events Bus
kubectl apply -k applications/argo-events-bus 


```
## Adding a new cluster to Argo CD

```bash
export KUBECONFIG=~/.kube/config
export CLUSTER_NAME=cluster-name
export CONNECT_HOST='https://connect.rspot.rye.ninja'

operator-sdk olm install
kubectl apply -k applications/sealed-secrets

# Create an overlay for the External Secrets Operator
mkdir -p overlays/$CLUSTER_NAME/external-secrets-operator/resources
cat <<EOF > overlays/$CLUSTER_NAME/external-secrets-operator/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: external-secrets-operator
resources:
  - ../../../applications/external-secrets-operator
  - resources/provider-auth-secret.yaml

patches:
- patch: |
    - op: replace
      path: /spec/provider/onepassword/connectHost
      value: $CONNECT_HOST
  target:
    group: external-secrets.io
    version: v1beta1
    kind: ClusterSecretStore
    name: onepassword
EOF

kubectl create secret generic onepassword-token -n external-secrets-operator \
  --from-literal=token=`op read --account ryefamily.1password.com op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential` \
  --dry-run=client -o yaml | kubeseal --controller-namespace=kubeseal --controller-name=sealed-secrets -o yaml \
  > overlays/$CLUSTER_NAME/external-secrets-operator/resources/provider-auth-secret.yaml

# Create an overlay for the External DNS Operator
mkdir -p overlays/$CLUSTER_NAME/external-dns
cat <<EOF > overlays/$CLUSTER_NAME/external-secrets-operator/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: external-dns
resources:
  - ../../../applications/external-dns-gateway-api

patches:
- patch: |
    - op: add
      path: /spec/template/spec/containers/0/args/0
      value: --txt-owner-id=$CLUSTER_NAME.rspot.rye.ninja
  target:
    group: apps
    version: v1
    kind: Deployment
    name: external-dns
EOF

```

What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.
