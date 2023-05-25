# 2. Use ArgoCD for Continuous Delivery

Date: 2023-05-24

## Status

Accepted

## Context

This project needs a continuous delivery tool to facilitate converging desired
state from source control into reality.

## Decision

ArgoCD will be used to manage the delivery of state to Kubernetes clusters in my lab.

## Consequences

ArgoCD must be the first application deployed in the lab environment and must
be manually deployed.  All other applications should utilize ArgoCD for their
deployement where feasible.

ArgoCD projects will be declared in [argocd/projects](../../../argocd/projects/).
Each kubernetes cluster in my environment will be assigned its own project.

ArgoCD applications will be declared in [argocd/apps](../../../argocd/apps/).

## Implementation

- [applications/argocd](../../../applications/argocd)
- [argocd/apps/argocd-projects.yaml](../../../argocd/apps/argocd-projects.yaml)
- [argocd/apps/argocd-apps.yaml](../../../argocd/apps/argocd-apps.yaml)

## Deployment

```bash
# Deploy ArgoCD and wait until fully deployed.
kubectl apply -k applications/argocd

# Deploy ArgoCD Application that tells Argo to monitor argocd/projects for changes.
kubectl apply -f applications/apps/argocd-projects.yaml

# Deploy ArgoCD Application that tells Argo to monitor argocd/apps for changes.
kubectl apply -f applications/apps/argocd-apps.yaml
```
