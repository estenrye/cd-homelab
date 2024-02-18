# LinkerD

## Documentation References

- https://linkerd.io/2.14/tasks/automatically-rotating-control-plane-tls-credentials/
- https://linkerd.io/2.14/tasks/automatically-rotating-webhook-tls-credentials/

## Installing Prerequisites

```bash
brew install step
brew install helm
brew install linkerd
```

## Prepare Signing Key

```bash
CLUSTER_NAME='rspot-wireguard'

# Create a new key pair for the controlplane certificates
step certificate create root.linkerd.cluster.local ca.crt ca.key \
  --profile root-ca --no-password --insecure

# Publish a new secret to 1password for the controlplane certificates
op item create \
  --account=ryefamily.1password.com \
  --vault=Home_Lab \
  --category="API Credential" \
  --title=controlplane.linkerd.${CLUSTER_NAME}.rye.ninja \
  --tags=linkerd \
  'tls\.crt[file]=./ca.crt' \
  'tls\.key[file]=./ca.key'

# Remove the local copy of the controlplane certificates
rm ./ca.crt ./ca.key

# Create a new key pair for the webhook certificates
step certificate create webhook.linkerd.cluster.local ca.crt ca.key \
  --profile root-ca --no-password --insecure --san webhook.linkerd.cluster.local

# Publish a new secret to 1password for the webhook certificates
op item create \
  --account=ryefamily.1password.com \
  --vault=Home_Lab \
  --category="API Credential" \
  --title=webhook.linkerd.${CLUSTER_NAME}.rye.ninja \
  --tags=linkerd \
  'certificate.cert[file]=./ca.crt' \
  'certificate.key[file]=./ca.key'

# Remove the local copy of the webhook certificates
rm ./ca.crt ./ca.key
```

