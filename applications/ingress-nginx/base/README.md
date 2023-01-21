# Ingress-Nginx Controller

This kustomize app uses helm chart inflation generators to 
deploy the Kubnernetes ingress-nginx controller.

This app is included as a resource in my cluster kustomize app.

## Building

```bash
kustomize build --enable-helm .
```

## Deploying

```bash
kustomize build --enable-helm . | kubectl apply -f -
```