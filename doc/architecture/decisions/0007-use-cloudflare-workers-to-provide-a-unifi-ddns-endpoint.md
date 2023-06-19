# 7. Use Cloudflare Workers to provide a Unifi DDNS Endpoint

Date: 2023-06-16

## Status

Accepted

## Context

I need an endpoint to configure Unifi DDNS clients to ping and update their
Cloudflare A record with their external IP address.

- [Using Cloudflare for Dynamic DNS on Unifi](https://www.devwithimagination.com/2022/05/28/using-cloudflare-for-dynamic-dns-on-unifi/), Dev With Imagination, David Hutchison, 2022-05-28
- [Cloudflare DDNS for UniFi OS](https://github.com/workerforce/unifi-ddns)
- [UniFi Gateway - Dynamic DNS](https://help.ui.com/hc/en-us/articles/9203184738583-UniFi-Gateway-Dynamic-DNS)

## Decision

Implement `Cloudflare DDNS for UniFi OS` Cloudflare Worker to proxy UniFi DDNS webhook calls.

## Consequences

Sites with UniFi OS configured to utilize the Cloudflare Worker will have their DNS A Record updated with the site's dynamically assigned public IP address.

## Installation Instructions

1. Install the Wrangler CLI.

```bash
brew install wrangler
```

1. Clone the repository

```bash
mkdir -p ${HOME}/src
cd ${HOME}/src
git clone https://github.com/workerforce/unifi-ddns.git
```

1. Authenticate to Cloudflare with `wrangler`

```bash
wrangler2 login
```

1. Publish the Cloudflare DDNS worker.

```bash
wrangler2 deploy
```

1. Follow the prompts.
1. Note the published `https://unifi-cloudflare-ddns.<worker_subdomain>.workers.dev` URL.

1. Configure UDM Pro

| Field | Value |
| --- | --- |
| Service  | dyndns                          |
| Hostname | `udm-subdomain.cloudflare.zone` |
| Username | `cloudflare.zone`               |
| Password | `cloudflare-api-token`          |
| Server   | `unifi-cloudflare-ddns.<worker_subdomain>.workers.dev/update?ip=%i&hostname=%h` |

1. Configure USG Pro 4

| Field | Value |
| --- | --- |
| Service  | dyndns                          |
| Hostname | `usg4-subdomain.cloudflare.zone` |
| Username | `cloudflare.zone`               |
| Password | `cloudflare-api-token`          |
| Server   | `unifi-cloudflare-ddns.<worker_subdomain>.workers.dev` |
