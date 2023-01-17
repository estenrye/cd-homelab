# cluster-info

This application creates the `cluster-info` namespace.  In this namespace, this
application defines a `OnePasswordItem` named `kustomization-replacements`.  The
1Password Connnect controller then creates a corresponding secret of the same name.

The resulting secret has the following structure:

```yaml
apiVersion: v1
data:
  cloudflare_api_token: Afejfewio===
  dns_suffix: Asfafdsa=
  email: adsfafd==
kind: Secret
metadata:
  name: kustomization-replacements
  namespace: cluster-info
type: Opaque
```

There is one overlay per cluster.  Each overlay applies a patch that sets the `itemPath`
of the `kustomization-replacements` OnePasswordItem.

## Deployment

```yaml
kubectl apply -k ${HOME}/cd-homelab/applications/clusterinfo/overlays/k8s-bare-metal.usmnblm01.rye.ninja
```