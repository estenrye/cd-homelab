# 17. managing deployments with argocd enviornment variables

Date: 2023-10-12

## Status

Accepted

## Context

I need a way to specify environment variables for my deployments to allow me to use the same deployment manifest for multiple environments.

I use kustomize to define my manifests and I want to use the same manifests for all environments.

I need a way to dynamically set environment variables for my deployments without having to modify the manifests themselves and instead specify them at deploy time using ArgoCD Application manifests.

### References

- [ApplicationSet + Kustomize, how to change Ingress host in template, discussion comment 4398836](https://github.com/argoproj/argo-cd/discussions/9042#discussioncomment-4398836)
- [Argocd + env var + applicationset + kustomize](https://github.com/argoproj/argo-cd/discussions/9814)

## Decision



## Consequences


