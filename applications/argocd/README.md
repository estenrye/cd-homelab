# ArgoCD

ArgoCD is the first application I deploy into a lab environment.  This will be deployed
to the bare metal cluster in my lab and will be used to continuously deliver applications
to the various clusters in my lab.  I only need one instance of ArgoCD to support all of
the clusters I deploy.

## Deployment

```bash

kubectl create secret generic -n argocd argocd-oidc-credentials \
  --from-literal=clientID=`op read op://Home_Lab/jumpcloud-oidc-secret_argocd.rye.ninja/username` \
  --from-literal=clientSecret=`op read op://Home_Lab/jumpcloud-oidc-secret_argocd.rye.ninja/credential`
kubectl label secret -n argocd argocd-oidc-credentials app.kubernetes.io/part-of=argocd
kubectl apply -k ${HOME}/cd-homelab/applications/argocd
```

## Upgrading ArgoCD

1. Update the tagged manifest under `resources` in `kustomization.yaml`.
2. Deploy
