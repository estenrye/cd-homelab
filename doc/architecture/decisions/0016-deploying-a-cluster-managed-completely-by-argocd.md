# 16. deploying a cluster managed completely by ArgoCD

Date: 2023-10-11

## Status

Accepted

## Prerequisites

- A kubernetes cluster.

    ```bash
    export AWS_PROFILE=ryezone-labs
    export AWS_REGION=us-east-2
    export CLUSTER_NAME=argo-cluster
    cat infrastructure/aws/public-with-spot.yaml | envsubst | eksctl create cluster -f -
    ```

- A secrets management system.
  I use 1Password.

    ```bash
    kubectl create namespace 1password
    kubectl create secret -n 1password generic op-credentials --from-literal=1password-credentials.json=`op read op://Home_lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json | base64`
    kubectl create secret -n 1password generic onepassword-token --from-literal=token=`op read op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential`
    kustomize build --enable-helm applications/1password | kubectl apply -f -
    kustomize build --enable-helm applications/argocd/base | kubectl apply -f -
    kustomize build --enable-helm applications/argocd/overlays/argocd.aws.rye.ninja | kubectl apply -f -
    ```
    ```
## Decision

The change that we're proposing or have agreed to implement.

## Consequences

What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.
