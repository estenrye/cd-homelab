cat <<EOF | kubectl delete -f -
apiVersion: v1
data: {}
kind: Secret
metadata:
  name: op-credentials
  namespace: 1password
type: Opaque
---
apiVersion: v1
data: {}
kind: Secret
metadata:
  name: onepassword-token
  namespace: 1password
type: Opaque
EOF

# Deploy the 1Password Credentials Secret
kubectl create secret generic op-credentials \
  -n 1password \
  --from-literal=1password-credentials.json=$(op read --account "${OP_ACCOUNT}" "${OP_CREDENTIALS_ITEM}" | base64 -b0)

# Deploy the 1Password Token Secret
kubectl create secret generic onepassword-token \
  -n 1password \
  --from-literal=token=$(op read --account "${OP_ACCOUNT}" "${OP_TOKEN_ITEM}")

cat <<EOF
{
    "cred_k8s_sha": "$(k get secret -n 1password op-credentials -o yaml | sha3sum | awk '{print $1}')",
    "token_k8s_sha": "$(k get secret -n 1password onepassword-token -o yaml | sha3sum | awk '{print $1}')",
}