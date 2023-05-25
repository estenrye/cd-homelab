# 3. Use Cloudflare for Hosting DNS

Date: 2023-05-24

## Status

Accepted

## Context

My home lab needs a Registar and a publicly accessible name server.
The name server should have a robust automation interface.
The registrar should not charge excessive renewal fees beyond what is required to register the domain with ICANN.
The name server should not be excessively expensive, less than $20 per month.

DNS provides human readable names for home lab services.  Cloudflare provides a great explainer document, [What is DNS?](https://www.cloudflare.com/learning/dns/what-is-dns/).

## Decision

Cloudflare will be the registrar and public name server for my home lab.

## Consequences

Kubernetes clusters hosted in my home lab will utilize 
[external-dns](https://github.com/kubernetes-sigs/external-dns) to automatically 
provision DNS A records and automatically synchronize the IP Address for the A 
record with the name server.

external-dns will be deployed using Kustomize using the manifests located 
[here](https://github.com/kubernetes-sigs/external-dns/tree/master/kustomize).

## Related Documentation

- [Setting up ExternalDNS for Services on Cloudflare](https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/cloudflare.md)

## Implementation

- [applications/external-dns/base](../../../applications/external-dns/base/)
  - This folder contains the common kustomize implementation for all of my Kubernetes clusters.

- [applications/external-dns/overlays/k8s-bare-metal](../../../applications/external-dns/overlays/k8s-bare-metal/)
  - This folder contains a cluster specific implementation.

- [argocd/apps/k8s-bare-metal.yaml](../../../argocd/apps/k8s-bare-metal.yaml)
  - This file defines the argocd app that deploys the cluster specific implementation.

- [charts/base/templates/external-dns.yaml](../../../charts/base/templates/external-dns.yaml)
  - This file is the template that creates an external-dns app using the app-of-apps ArgoCD pattern.