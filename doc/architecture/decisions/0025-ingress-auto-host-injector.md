# 25. Ingress Auto Host Injector

Date: 2025-02-21

## Status

Proposed

## Context

I need a mutating webhook that can automatically inject the host into the Ingress resource. 
This is useful for when the Ingress resource is created by a user and they don't want to 
specify the host themselves.  It is also useful in cases where I want to avoid implementing 
a kustomize overlay configuration just to override the host on the Ingress resource.  For
example, In the case where I deploy consul with ArgoCD as an Application Set, I currently
set the following for Ingress objects:

```yaml
  ingress:
    enabled: true
    ingressClassName: haproxy
    pathType: Prefix
    annotations: |
      'cert-manager.io/cluster-issuer': zerossl-production
      'external-dns.alpha.kubernetes.io/ttl': "60"
    hosts:
      - host: consul-ui.cluster.infra.rye.ninja
        paths:
          - /
    tls:
      - hosts:
          - consul-ui.cluster.infra.rye.ninja
        secretName: consul-ui-tls
```

This is a lot of configuration for a simple Ingress resource and requires a cluster specific
overlay configuration for each cluster I deploy it to.

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
namespace: consul-vault
resources:
  - ../../../applications/consul

patches:
- patch: |
    - op: replace
      path: /spec/rules/0/host
      value: consul-ui.rspot.rye.ninja
    - op: replace
      path: /spec/tls/0/hosts/0
      value: consul-ui.rspot.rye.ninja
  target:
    group: networking.k8s.io
    version: v1
    kind: Ingress
    name: consul-consul-ui
- patch: |
    - op: replace
      path: /spec/rules/0/host
      value: consul-server.rspot.rye.ninja
    - op: replace
      path: /spec/tls/0/hosts/0
      value: consul-server.rspot.rye.ninja
  target:
    group: networking.k8s.io
    version: v1
    kind: Ingress
    name: consul-consul-server
```

As this is the only patch I need to make from cluster to cluster, it would be nice to have
a mutating webhook that can automatically inject the host into the Ingress resource based on
a set of annotations, hostname templates and path templates on the Ingress and IngressClass 
Resources.

The webhook should be able to populate hostnames templates in the following host patterns:

- `{{.Name}}.{{ZoneSuffix}}`
- `*.{{.Name}}.{{ZoneSuffix}}`
- `{{.Namespace}}.{{ZoneSuffix}}`
- `*.{{.Namespace}}.{{ZoneSuffix}}`
- `{{.Name}}.{{.Namespace}}.{{.ZoneSuffix}}`
- `*.{{.Name}}.{{.Namespace}}.{{.ZoneSuffix}}`
- `{{.Name}}-{{.Namespace}}.{{.ZoneSuffix}}`
- `*.{{.Namespace}}-{{.Name}}.{{.ZoneSuffix}}`
- `{{.Namespace}}.{{.Name}}.{{.ZoneSuffix}}`
- `*.{{.Namespace}}.{{.Name}}.{{.ZoneSuffix}}`
- `{{.Namespace}}-{{.Name}}.{{.ZoneSuffix}}`
- `*.{{.Namespace}}-{{.Name}}.{{.ZoneSuffix}}`


The webhook should be able to populate path templates in the following path patterns

- `/{{.Namespace}}`
- `/{{.Name}}`
- `/{{.Namespace}}/{{.Name}}`
- `/{{.Name}}/{{.Namespace}}`
- `/{{.Namespace}}-{{.Name}}`
- `/{{.Name}}-{{.Namespace}}`
- `/foo/{{.Namespace}}/{{.Name}}`

## Potential ConfigMap Schema

```yaml
data:
  defaultTemplate:
    host:
      enabled: true
      template: "{{.Name}}.{{Namespace}}.{{ZoneSuffix}}"
    path:
      enabled: false
  ingressClassTemplates:
    haproxy:
      default:
        host:
          enabled: true
          template: "app.{{ZoneSuffix}}"
        pathTemplate: 
          enabled: true
          template: "/{{.Namespace}}/{{.Name}}"
      namespaceTemplates:
        consul:
          host:"{{.Name}}.kv.{{ZoneSuffix}}"
          pathTemplate: "/"
    nginx:
      default:
        hostTemplate: "{{.Namespace}}.{{ZoneSuffix}}"
        pathTemplate: "/{{.Name}}"
      namespaceTemplates: {}

```

## Decision

The change that we're proposing or have agreed to implement.

## Consequences

What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.
