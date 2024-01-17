# 22. Adopting the Gateway API using NGINX Gateway Fabric

Date: 2024-01-17

## Status

Investigating

## Context

The default Ingress Controller for Kubernetes is NGINX Ingress Controller. It is a mature and stable project that has been around for a long time. It is also
limited in the fact that the Ingress API is not as expressive as the Gateway API. The Gateway API is a new API that is being developed by the Kubernetes SIG Network. 
The Gateway API is a more expressive API that allows for more complex routing rules and is more flexible than the Ingress API.  This includes TCP and UDP routing, GRPC routing,
and more.  

The NGINX Gateway Fabric is a new project that is being developed by NGINX.  It is
a new Ingress Controller that is built on top of the Gateway API.  It is a new project that is still in the early stages of development.  Currently at 1.1, I want to evaluate
it as a potential replacement for the NGINX Ingress Controller as a way to minimize the
number of loadbalancers created on my Rackspace SPOT Kubernetes clusters.

## References

- [Gateway API](https://gateway-api.sigs.k8s.io/)
- [5 Reasons to Try the Kubernetes Gateway API](https://www.nginx.com/blog/5-reasons-to-try-the-kubernetes-gateway-api/)
- [NGINX Gateway Fabric](https://github.com/nginxinc/nginx-gateway-fabric?tab=readme-ov-file)
- [Why We Decided to Start Fresh with Our NGINX Gateway Fabric](https://www.nginx.com/blog/why-we-decided-to-start-fresh-with-our-nginx-gateway-fabric/)
- [NGINX Gateway Fabric Documentation](https://docs.nginx.com/nginx-gateway-fabric/)
- [NGINX Gateway Fabric 1.0 demo with Gateway API - KubeCon NA 2023](https://youtu.be/4sjtal_kN5M)
- [Getting started with Gateway API](https://gateway-api.sigs.k8s.io/guides/#installing-gateway-api)

## Decision - Managing the Gateway API Custom Resources

I have decided to install the custom resources using a separate ApplicationSet.  This will allow me to manage the custom resources separately from the NGINX Gateway Fabric
installation.  This will also allow me to experiment with multiple Gateway API implementations more easily.

To manage the installation and upgrade of the Gateway API custom resources, I have
crdated a [kustomization.yaml](../../../applications/gateway-api/kustomization.yaml) 
file that will control the version of the Gatway API that gets installed.

This is deployed on clusters with the `rye.ninja/gateway-api-enabled: "true"` label
on their ArgoCD Cluster Secret object using an [ApplicationSet](../../../applications/argocd-appsets/appsets/gateway-api.yaml).

## Consequences

What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.
