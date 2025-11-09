# 26. Deployment Instructions

Date: 2025-11-03

## Status

Accepted

## Context

### Deploy the Priority Classes

```bash
kubectl apply -k applications/priority-classes
```

### Deploy the Sealed Secrets controller

```bash
kustomize build --enable-helm applications/sealed-secrets | kubectl apply -f -
```

### Update the 1Password Operator Secrets in Source Control

```bash
kubectl create secret generic op-credentials -n 1password \
  --from-literal=1password-credentials.json=`op read --account ryefamily.1password.com op://Home_lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json | base64` \
  --dry-run=client -o yaml | kubeseal --controller-namespace=kubeseal --controller-name=sealed-secrets -o yaml \
  > overlays/in-cluster/1password/resources/sealed-secrets-credentials.yaml

kubectl create secret generic onepassword-token -n 1password \
  --from-literal=token=`op read --account ryefamily.1password.com op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential` \
  --dry-run=client -o yaml | kubeseal --controller-namespace=kubeseal --controller-name=sealed-secrets -o yaml \
  > overlays/in-cluster/1password/resources/sealed-secrets-token.yaml
```

### Deploy the 1Password Operator and Secrets Injector

```bash
kustomize build --enable-helm overlays/in-cluster/1password | kubectl apply -f -
```

### Deploy the Kube-Prometheus Stack

```bash
# Run Twice
kustomize build --enable-helm applications/kube-prometheus-stack | kubectl apply --server-side -f -
```

### Install the Gateway API

```bash
kubectl apply -k applications/gateway-api
```


### Deploy Cert-Manager

```bash
kustomize build --enable-helm applications/cert-manager | kubectl apply --server-side -f -
```

### Install External Secrets Operator

```bash
kustomize build --enable-helm applications/external-secrets-operator | kubectl apply --server-side -f -

kubectl create secret generic onepassword-token -n external-secrets-operator \
  --from-literal=token=`op read --account ryefamily.1password.com op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential` \
  --dry-run=client -o yaml | kubeseal --controller-namespace=kubeseal --controller-name=sealed-secrets -o yaml \
  > overlays/in-cluster/external-secrets-operator/resources/provider-auth-secret.yaml

kubectl apply -k overlays/in-cluster/external-secrets-operator --server-side
```

### Deploy Cluster Issuer

```bash
kubectl apply -k applications/zerossl-cluster-issuer
```

### Deploy External DNS

```bash
kustomize build --enable-helm overlays/in-cluster/external-dns | kubectl apply --server-side -f -
```

### Deploy haproxy-ingress Ingress Controller

```bash
kustomize build --enable-helm applications/haproxy-ingress | kubectl apply -f -
```

### Deploy envoy-gateway Gateway Controller

```bash
kustomize build --enable-helm applications/envoy-gateway | kubectl apply --server-side -f -
```

