set -e

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
