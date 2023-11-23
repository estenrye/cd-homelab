# 1Password

## Overview

This directory contains the manifests for the 1Password Connect operator.

1Password Connect provides a custom resource definition
and Kubernetes controller to automatically provision
secrets stored 1Password Family or Teams.

1Password Connect provides two methods for injecting
secrets into a namespace.

1. Custom Resource Definition

   ```yaml
   apiVersion: onepassword.com/v1
   kind: OnePasswordItem
   metadata:
   name: secret-name
   namespace: target-namespace
   labels:
      label-replicated-to-secret: value
   spec:
      itemPath: "vaults/<vault_id_or_title>/items/<item_id_or_title>"
   ```

2. Deployment Annotation

   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   metadata:
   name: deployment-example
   annotations:
      operator.1password.io/item-path: "vaults/<vault_id_or_title>/items/<item_id_or_title>"
      operator.1password.io/item-name: "<secret_name>"
   ```

1Password Secrets Injector provides a third method
for injecting secrets into a namespace.  For instructions,
see [1Password Kubernetes Injector](https://developer.1password.com/docs/connect/k8s-injector)
documentation.

## Dependencies

This manifest has no dependencies.

## Installation

1. Run the following commands to install the required secrets for the 1Password Connect operator.
```bash
kubectl create secret generic op-credentials -n 1password --from-literal=1password-credentials.json=`op read --account ryefamily.1password.com op://Home_lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json | base64`
kubectl create secret generic onepassword-token -n 1password --from-literal=token=`op read --account ryefamily.1password.com op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential`
```