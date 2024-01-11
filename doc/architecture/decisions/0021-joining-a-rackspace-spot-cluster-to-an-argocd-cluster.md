# 21. Joining a Rackspace Spot Cluster to an ArgoCD cluster

Date: 2024-01-05

## Status

In Progress

## Joining the cluster to ArgoCD

1. Create a new namespace for 1Password in the cluster.

    ```bash
    kubectl create namespace 1password
    ```

2. Create a new secret in the cluster for the 1Password credentials.

    ```bash
    kubectl create secret generic -n 1password op-credentials \
      --from-literal=1password-credentials.json=`op read --account ryefamily.1password.com op://Home_lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json | base64`
    ```

3. Create a new secret in the cluster for the 1Password Connect token

   ```bash
   kubectl create secret generic -n 1password onepassword-token \
     --from-literal=token=`op read --account ryefamily.1password.com op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential`
   ```

4. Create and apply the following secret to the cluster hosting ArgoCD

    ```yaml
    apiVersion: v1
    kind: Secret
    metadata:
        name: rspot-wireguard
        namespace: argocd
        labels:
            argocd.argoproj.io/secret-type: cluster
            rye.ninja/egress-load-balancer: svc-load-balancer
            rye.ninja/environment: wireguard
            rye.ninja/kubernetes-provider: rackspace-spot
    stringData:
        name: rspot-wireguard
        # URI from Rackspace Spot cluster Kubeconfig file.
        server: https://spot.rackspace.com/apis/ngpc.rxt.io/v1/namespaces/org-pduvfizupzbnb6dq/cloudspaces/rspot-wireguard/proxy
        config: | 
            {
                "bearerToken": "token-from-kubeconfig",
                "tlsClientConfig": {
                "insecure": true
                }
            }
        ```

## Patching the token after it expires.

Currently the token expires after an amount of time that I haven't determined yet.  When the token expires, the cluster will no longer be able to communicate with the ArgoCD cluster.  To update the token, follow these steps:

1. Download the kubeconfig file for the cluster from Rackspace Spot to a known location.
2. With your ArgoCD cluster as your current kubeconfig context, run the following commands:

```bash
CLUSTER_SECRET_NAME=rspot-wireguard
KUBECONFIG_FILE=~/Downloads/rspot-wireguard-kubeconfig.yml
BEARER_TOKEN=`yq '.users[0].user.token' ${KUBECONFIG_FILE}`
TMP_FILE=$(mktemp).json
kubectl get secret -n argocd ${CLUSTER_SECRET_NAME} -o jsonpath={.data.config} | base64 -d | jq ".bearerToken=\"${BEARER_TOKEN}\"" > ${TMP_FILE}
kubectl patch secret -n argocd ${CLUSTER_SECRET_NAME} --patch="{\"data\": { \"config\":\"$(cat ${TMP_FILE} | base64 -b 0)\" }}"
rm ${TMP_FILE}
```

## Decision

The change that we're proposing or have agreed to implement.

## Consequences

What becomes easier or more difficult to do and any risks introduced by the change that will need to be mitigated.
