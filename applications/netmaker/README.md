# Netmaker

## Initializing Secrets in 1Password

```bash
CLUSTER_NAME=rspot-wireguard

ADMIN_PASSWORD=$(openssl rand -base64 32)
op item template get Password | op item create \
  --vault=Home_Lab \
  --generate-password \
  --title="pgpool.nm.${CLUSTER_NAME}.rye.ninja" \
  admin-password="${ADMIN_PASSWORD}"

REPMGR_PASSWORD=$(openssl rand -base64 32)
op item template get Password | op item create \
  --vault=Home_Lab \
  --generate-password \
  --title="postgresql.nm.${CLUSTER_NAME}.rye.ninja" \
  repmgr-password="${REPMGR_PASSWORD}"

```