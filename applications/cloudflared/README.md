# CloudflareD

## Introduction

CloudflareD is a tool that allows you to expose your local network to the Internet via Cloudflare's Argo Tunnel.

## Prerequisites

- A Cloudflare account
- A domain name
- cloudflared installed on your local machine

## Creating the Tunnel

```bash
brew install cloudflared
cloudflared tunnel login
TUNNEL_NAME='rspot-home-lab'
cloudflared tunnel create ${TUNNEL_NAME}
TUNNEL_ID=`cloudflared tunnel list --name ${TUNNEL_NAME} -o json | jq -r '. | first | .id'`

op item create \
  --account=ryefamily.1password.com \
  --vault=Home_Lab \
  --category="API Credential" \
  --title=cloudflared.${TUNNEL_ID}.rye.ninja \
  --tags=cloudflared \
  "cloudflared.credentials\.json[file]=${HOME}/.cloudflared/${TUNNEL_ID}.json"

cloudflared tunnel route dns ${TUNNEL_ID} "*.${TUNNEL_NAME}.rye.ninja"
```

## Deploying the Tunnel

```bash
TUNNEL_NAME='rspot-home-lab'
ITEM_PATH="vaults/Home_Lab/items/cloudflared.${TUNNEL_NAME}.rye.ninja"
helm upgrade --install cloudflared \
  --namespace cloudflared \
  --create-namespace \
  --set cloudflare-tunnel.cloudflare.tunnelName=${TUNNEL_NAME} \
  --set credentials.itemPath=${ITEM_PATH} \
  ${HOME}/src/cd-homelab/applications/cloudflared
```
