# 1Password

## Installation

1. Run the following commands to install the required secrets for the 1Password Connect operator.
```bash
kubectl create secret generic op-credentials --from-literal=1password-credentials.json=`op read op://Home_lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json | base64`
kubectl create secret generic onepassword-token --from-literal=token=`op read op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential | base64`
```