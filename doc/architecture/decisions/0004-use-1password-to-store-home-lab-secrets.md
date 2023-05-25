# 4. Use 1Password to Store Home Lab Secrets

Date: 2023-05-25

## Status

Accepted

## Context

Home labs often require sensitive secrets that cannot be committed to public
source control repositories.  To facilitate the public sharing of this repo
these secrets must be stored in a separate, private system.  This system should
support Kubernetes integration.

## Decision

1Password shall store all home lab secrets.

## Consequences

All home lab secrets will be stored in the `Home_Lab` vault of my personal 
1Password Family account.

1Password Family requires an Annual Spend of $60 per year.
1Password Family provides three vault access tokens for free.
One vault access token will be consumed to enable Kubernetes integration.

The [1Password Connect API and Operator](https://github.com/1Password/connect-helm-charts/tree/main/charts/connect)
will be installed in every Kubernetes cluster I deploy in my home lab.  This
provides a custom resource definition that will allow me to provision 
`1PasswordItem` resources that the operator will use to retrieve the secret
value from 1Password and place in a Kubernetes `Secret` object.  Because the
`1PasswordItem` resources only contain a path to the secret value they are
safe to commit in a public repository.

The [1Password Secrets Injector](https://github.com/1Password/connect-helm-charts/tree/main/charts/secrets-injector)
will be installed in every Kubernetes cluster I deploy in my home lab.  This
operator utilizes a mutating web hook to automatically inject values into a
deployment.  This method of injectio is extriemely useful when an application
supports environment variables to drive configuration and using a `Secret`
would be too cumbersome or difficult.

## Implementation

- [applications/1password](../../../applications/1password)
- [argocd/apps/k8s-bare-metal.yaml](../../../argocd/apps/k8s-bare-metal.yaml)
- [charts/base/templates/1password.yaml](../../../charts/base/templates/1password.yaml)