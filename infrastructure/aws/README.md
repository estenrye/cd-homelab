# Deploying an EKS Cluster

## Cluster configuration

- Deploys to three availability zones.
  - us-east-2a
  - us-east-2b
  - us-east-2c

- IPV4 Networking

- One Managed Node group
  - 3 nodes
  - 4 cores
  - 8 GB RAm

## Prerequisites

- RSA based SSH Key

```bash
ssh-keygen -t rsa -b 4096 -C "esten@Mac-JX2QJRP9RH"
```
## Deployment

```bash
export AWS_PROFILE=ryezone-labs
export AWS_REGION=us-east-2
export CLUSTER_NAME=argo-cluster
cat public-with-spot.yaml | envsubst | eksctl create cluster -f -
```