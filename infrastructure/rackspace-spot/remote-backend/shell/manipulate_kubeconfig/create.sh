cat <<EOF > $KUBECONFIG_PATH
apiVersion: v1
clusters:
- cluster:
    insecure-skip-tls-verify: true
    server: https://$SERVER
  name: $NAME
contexts:
- context:
    cluster: $NAME
    namespace: default
    user: ngpc-user
  name: $NAME
- context:
    cluster: $NAME
    namespace: default
    user: oidc
  name: $NAME-oidc
current-context: $NAME
kind: Config
preferences: {}
users:
- name: ngpc-user
  user:
    token: $TOKEN
- name: oidc
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      args:
      - oidc-login
      - get-token
      - --oidc-issuer-url=https://login.spot.rackspace.com/
      - --oidc-client-id=mwG3lUMV8KyeMqHe4fJ5Bb3nM1vBvRNa
      - --oidc-extra-scope=openid
      - --oidc-extra-scope=profile
      - --oidc-extra-scope=email
      - --oidc-auth-request-extra-params=organization=$ORG_ID
      - --token-cache-dir=~/.kube/cache/oidc-login/$ORG_ID
      command: kubectl
      env: null
      interactiveMode: IfAvailable
      provideClusterInfo: false
EOF

cat <<EOF
{
    "path": "$KUBECONFIG_PATH",
    "md5": "$(sha3sum $KUBECONFIG_PATH | awk '{print $1}')"
}
EOF