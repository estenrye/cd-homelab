# 23. implementing gateway api and service mesh

Date: 2024-03-23

## Status

In Design

## ToDo

[ ] Document how to configure the 1Password Secrets integration
[ ] Document how to configure Cloudflare DNS
[ ] Implement Default Deny for LinkerD
[ ] Implement Server and Server Authorization resources for example applications.
[ ] Implement a single kube-prometheus stack shared by Envoy Gateway and LinkerD
[ ] Implement Loki for log aggregation
[ ] Forward all logs to Loki
[ ] Implement a single trace storage solution  (linkerd jaegar or grafana tempo)
[ ] Implement the OpenTelemetry Collector for telemetry data collection
[ ] Collect Gateway API Metrics using Prometheus
  - [Envoy Gateway: Gateway API Metrics](https://gateway.envoyproxy.io/v1.0.0/user/observability/gateway-api-metrics/)
  - [Gateway API State Metrics](https://github.com/Kuadrant/gateway-api-state-metrics)
[ ] Install grafana

## References

- [Gateway API](https://gateway-api.sigs.k8s.io/)
- [Gateway API 1.0.0 Release](https://github.com/kubernetes-sigs/gateway-api/releases/tag/v1.0.0)
- [Cert-Manager](https://cert-manager.io/)
- [Envoy Control Plane Authentication using custom certs](https://gateway.envoyproxy.io/v1.0.0/install/custom-cert/)
- [Envoy Install with Helm](https://gateway.envoyproxy.io/v1.0.0/install/install-helm/)
- [Automatically Rotating Control Plane TLS Credentials](https://linkerd.io/2.15/tasks/automatically-rotating-control-plane-tls-credentials/)
- [Automatically Rotating Webhook TLS Credentials](https://linkerd.io/2.15/tasks/automatically-rotating-webhook-tls-credentials/)
- [Github Kubernetes Replicator](https://github.com/mittwald/kubernetes-replicator)
- [Emojivoto](https://github.com/BuoyantIO/emojivoto)
- [Envoy Gateway: Using cert-manager for TLS Termination](https://gateway.envoyproxy.io/v1.0.0/user/security/tls-cert-manager/)
- [Envoy Gateway: Using ExteranlDNS](https://gateway.envoyproxy.io/v1.0.0/user/security/tls-cert-manager/#using-externaldns)

## Implementation

### Prerequisite Applications

```bash
brew install helm
brew install yq
brew install kubectl
brew install linkerd
brew install hey
brew install op
```

### Prerequisite Services

- Rackspace SPOT Account
- DNS Provider supported by External-DNS
- 1Password Family Account (optional)

### Provision a Cloudspace on Rackspace SPOT

```bash
# provision a cluster on Rackspace SPOT
cd infrastructure/rackspace-spot/remote-backend
task remote-backend-apply
```

### Configure 1Password Secrets Integration

TODO: Document how to configure 1Password Secrets Integration

### Deploy 1Password Operator

I use 1Password to store my secrets. We're going to deploy the 1Password Operator to my cluster to deliver my secrets.
to the cluster.  If you don't have a 1Password account, anywhere you see a OnePasswordItem object in the following guide,
you can replace it with a Kubernetes Secret.

```bash
export OP_ACCOUNT="ryefamily.1password.com"
export OP_CREDENTIALS_ITEM="op://Home_lab/1Password-Connect-Credentials-File-usmnblm01.rye.ninja/1password-credentials.json"
export OP_TOKEN_ITEM="op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential"

# Create the 1Password namespace
kubectl create namespace 1password

# Deploy the 1Password Credentials Secret
kubectl create secret generic op-credentials \
  -n 1password \
  --from-literal=1password-credentials.json=$(op read --account "${OP_ACCOUNT}" "${OP_CREDENTIALS_ITEM}" | base64)

# Deploy the 1Password Token Secret
kubectl create secret generic onepassword-token \
  -n 1password \
  --from-literal=token=$(op read --account "${OP_ACCOUNT}" "${OP_TOKEN_ITEM}")

# Add the 1Password Helm Repository
helm repo add 1password https://1password.github.io/connect-helm-charts

# Install the 1Password Operator
helm upgrade --install connect 1password/connect \
  --namespace 1password \
  --set operator.create=true \
  --set operator.autoRestart=true \
  --set connect.ingress.enabled=false
```

### Configure Cloudflare DNS

TODO: Document how to configure Cloudflare DNS

### Deploy External-DNS

Next, we're going to deploy External-DNS to manage the DNS records for our Gateway.
External-DNS is a Kubernetes controller that configures DNS records for Kubernetes resources.

```bash
# Create the External-DNS namespace
kubectl create namespace external-dns

# Add the Cloudflare API Token to the cluster
export CLOUDFLARE_API_TOKEN_ITEM="vaults/Home_Lab/items/letsencrypt-dns01-credentials_cert-manager.rye.ninja"

cat <<EOF | kubectl apply -f -
apiVersion: onepassword.com/v1
kind: OnePasswordItem
metadata:
  name: dns-credentials
  namespace: external-dns
spec:
  itemPath: ${CLOUDFLARE_API_TOKEN_ITEM}
EOF

# Add the External-DNS Helm Repository
helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/

# Deploy External-DNS
export CLUSTER_NAME="example"
export TOP_LEVEL_DOMAIN="rye.ninja"

helm upgrade --install external-dns external-dns/external-dns \
  --namespace external-dns \
  --set logLevel=debug \
  --set logFormat=json \
  --set interval=5m \
  --set triggerLoopOnEvent=true \
  --set registry=txt \
  --set txtPrefix=edns. \
  --set txtOwnerId="${CLUSTER_NAME}" \
  --set policy=sync \
  --set sources="{gateway-httproute,gateway-grpcroute,gateway-tcproute,gateway-tlsroute,gateway-udproute}" \
  --set provider.name=cloudflare \
  --set extraArgs="{--cloudflare-proxied,--cloudflare-dns-records-per-page=5000}" \
  --set "env[0].name=CF_API_TOKEN" \
  --set "env[0].valueFrom.secretKeyRef.name=dns-credentials" \
  --set "env[0].valueFrom.secretKeyRef.key=password" \
  --set "env[1].name=EXTERNAL_DNS_ZONE_ID_FILTER" \
  --set "env[1].valueFrom.secretKeyRef.name=dns-credentials" \
  --set "env[1].valueFrom.secretKeyRef.key=zone_id" \
  --set "domainFilters[0]=${CLUSTER_NAME}.${TOP_LEVEL_DOMAIN}"
```

### Deploy the Kubernetes Replicator

We'll be using the Kubernetes Replicator to replicate the certificate secret for the LinkerD Webhook Issuer.

```bash
# Add the Mittwald Helm Repository
helm repo add mittwald https://helm.mittwald.de --force-update

# Install the Kubernetes Replicator Helm Chart
helm upgrade --install kubernetes-replicator mittwald/kubernetes-replicator -n kube-system
```

### Deploy Cert-manager

We'll be using Cert-manager to manage the certificates for the Gateway API and the Envoy Gateway Controller. Cert-manager is a Kubernetes add-on to automate the management and issuance of TLS certificates from various issuing sources.

```bash
# Install the Cert Manager CRDs
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.crds.yaml

# Add the Jetstack Helm Repository
helm repo add jetstack https://charts.jetstack.io --force-update

# Install the Cert Manager Helm Chart
helm upgrade --install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.14.4 \
  --set featureGates=ExperimentalGatewayAPISupport=true
```

### Deploy the Gateway API CRDs

We're going to deploy the Gateway API CRDs to our cluster. The Gateway API is a Kubernetes project that aims to provide a declarative way to configure Layer 7 routing in Kubernetes.  We're going to manage the Gateway API CRDs separately from the Envoy Gateway Controller.

```bash
# Install the Gateway API CRDs
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/experimental-install.yaml
```

### Provision the Certificates for the Envoy Gateway Controller
```bash
# Create the envoy-system namespace
kubectl create namespace envoy-gateway-system

# Create a self-signed issuer for the Envoy Gateway Controlplane
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  labels:
    app.kubernetes.io/name: envoy-gateway
  name: selfsigned-issuer
  namespace: envoy-gateway-system
spec:
  selfSigned: {}
EOF

# Create a Certificate for the Envoy Gateway CA
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: envoy-gateway-ca
  namespace: envoy-gateway-system
spec:
  isCA: true
  commonName: envoy-gateway
  secretName: envoy-gateway-ca
  duration: 87600h00m
  renewBefore: 8761h00m
  privateKey:
    algorithm: RSA
    size: 2048
    rotationPolicy: Always
  issuerRef:
    name: selfsigned-issuer
    kind: Issuer
    group: cert-manager.io
EOF

# Create an Issuer for the Envoy Gateway CA
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  labels:
    app.kubernetes.io/name: envoy-gateway
  name: eg-issuer
  namespace: envoy-gateway-system
spec:
  ca:
    secretName: envoy-gateway-ca
EOF

# Create a Certificate for the Envoy Gateway Controller
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  labels:
    app.kubernetes.io/name: envoy-gateway
  name: envoy-gateway
  namespace: envoy-gateway-system
spec:
  commonName: envoy-gateway
  duration: 2160h00m
  renewBefore: 1081h00m
  dnsNames:
  - "envoy-gateway"
  - "envoy-gateway.envoy-gateway-system"
  - "envoy-gateway.envoy-gateway-system.svc"
  - "envoy-gateway.envoy-gateway-system.svc.cluster.local"
  privateKey:
    rotationPolicy: Always
  issuerRef:
    kind: Issuer
    name: eg-issuer
  usages:
  - "digital signature"
  - "data encipherment"
  - "key encipherment"
  - "content commitment"
  secretName: envoy-gateway
EOF

# Create a Certificate for the envoy proxy
cat<<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  labels:
    app.kubernetes.io/name: envoy-gateway
  name: envoy
  namespace: envoy-gateway-system
spec:
  commonName: "*"
  duration: 2160h00m
  renewBefore: 1081h00m
  dnsNames:
  - "*.envoy-gateway-system"
  privateKey:
    rotationPolicy: Always
  issuerRef:
    kind: Issuer
    name: eg-issuer
  usages:
  - "digital signature"
  - "data encipherment"
  - "key encipherment"
  - "content commitment"
  secretName: envoy
EOF

# Create a Certificate for the envoy-rate-limit
cat<<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  labels:
    app.kubernetes.io/name: envoy-gateway
  name: envoy-rate-limit
  namespace: envoy-gateway-system
spec:
  commonName: "*"
  duration: 2160h00m
  renewBefore: 1081h00m
  dnsNames:
  - "*.envoy-gateway-system"
  privateKey:
    rotationPolicy: Always
  issuerRef:
    kind: Issuer
    name: eg-issuer
  usages:
  - "digital signature"
  - "data encipherment"
  - "key encipherment"
  - "content commitment"
  secretName: envoy-rate-limit
EOF
```

### Deploy the Envoy Gateway Controller

We're going to deploy the Envoy Gateway Controller to our cluster. The Envoy Gateway Controller is a Kubernetes controller that implements the Gateway API. The Envoy Gateway Controller will be responsible for configuring the Envoy Proxy instances that will be used to route north-south traffic to our services.

```bash
# Deploy the Envoy Gateway Helm Chart
helm install eg oci://docker.io/envoyproxy/gateway-helm --version v1.0.0 -n envoy-gateway-system --create-namespace

# Wait for the Envoy Gateway Controller to be ready
kubectl wait --timeout=5m -n envoy-gateway-system deployment/envoy-gateway --for=condition=Available

```

### Test the Envoy Gateway Controller

We're going to test the Envoy Gateway Controller by deploying a Gateway, HttpRoute, and a test application to our cluster. We'll then test the Gateway by sending a request to the Gateway's IP Address.

```bash
# Deploy a Gateway, HttpRoute and a test application
linkerd inject https://github.com/envoyproxy/gateway/releases/download/latest/quickstart.yaml \
  | kubectl apply -n default -f -

# Get the IP Address of the Gateway
export IP_ADDRESS=`kubectl get gateway -n default eg -o yaml | yq ".status.addresses[0].value"`

# Test the Gateway
curl -v ${IP_ADDRESS} -H "Host: www.example.com"
```

### Check LinkerD and Install LinkerD CRDs

We're going to deploy LinkerD to our cluster. LinkerD is a service mesh that provides observability, reliability, and security for the east-west communication of our services.

```bash
# Check the cluster to ensure it is configured correctly for LinkerD
linkerd check --pre

# install the CRDs first
linkerd install --crds | kubectl apply -f -
```

### Create a Self-Signed Issuer for the LinkerD Controlplane

```bash
# Create the LinkerD namespace
kubectl create namespace linkerd
kubectl create namespace linkerd-viz
kubectl create namespace linkerd-jaeger

# Create a self-signed issuer for the LinkerD CA
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  labels:
    app.kubernetes.io/name: linkerd
  name: selfsigned-issuer
  namespace: linkerd
spec:
  selfSigned: {}
EOF
```

### Generate the LinkerD Controlplane Trust Anchor and Identity 

[Automatically Rotating Control Plane TLS Credentials](https://linkerd.io/2.15/tasks/automatically-rotating-control-plane-tls-credentials/)

```bash
# Create a Certificate for the LinkerD CA Issuer
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: linkerd-trust-anchor
  namespace: linkerd
spec:
  isCA: true
  commonName: root.linkerd.cluster.local
  duration: 87600h00m
  renewBefore: 8761h00m
  secretName: linkerd-trust-anchor
  privateKey:
    rotationPolicy: Always
    algorithm: RSA
    size: 2048
  issuerRef:
    name: selfsigned-issuer
    kind: Issuer
    group: cert-manager.io
EOF

# Create an Issuer for the LinkerD CA
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: linkerd-trust-anchor
  namespace: linkerd
spec:
  ca:
    secretName: linkerd-trust-anchor
EOF

# Create a Certificate for the LinkerD Identity Issuer
kubectl apply -f - <<EOF
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: linkerd-identity-issuer
  namespace: linkerd
spec:
  secretName: linkerd-identity-issuer
  duration: 2160h00m
  renewBefore: 1081h00m
  issuerRef:
    name: linkerd-trust-anchor
    kind: Issuer
  commonName: identity.linkerd.cluster.local
  dnsNames:
  - identity.linkerd.cluster.local
  isCA: true
  privateKey:
    rotationPolicy: Always
    algorithm: ECDSA
  usages:
  - cert sign
  - crl sign
  - server auth
  - client auth
EOF
```
### Generate the LinkerD Webhook Trust Chain

[Automatically Rotating Webhook TLS Credentials](https://linkerd.io/2.15/tasks/automatically-rotating-webhook-tls-credentials/)

```bash
# Create a Certificate for the LinkerD Webhook Trust Chain
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: webhook-issuer
  namespace: linkerd
spec:
  isCA: true
  commonName: webhook.linkerd.cluster.local
  duration: 87600h00m
  renewBefore: 8761h00m
  secretName: webhook-issuer-tls
  secretTemplate:
    annotations:
      replicator.v1.mittwald.de/replicate-to: "linkerd-viz,linkerd-jaeger"
  privateKey:
    rotationPolicy: Always
    algorithm: RSA
    size: 2048
  issuerRef:
    name: selfsigned-issuer
    kind: Issuer
    group: cert-manager.io
EOF

# Create an Issuer for the LinkerD Webhook Trust Chain in the linkerd namespace
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: webhook-issuer
  namespace: linkerd
spec:
  ca:
    secretName: webhook-issuer-tls
EOF

# Create an Issuer for the LinkerD Webhook Trust Chain in the linkerd-viz namespace
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: webhook-issuer
  namespace: linkerd-viz
spec:
  ca:
    secretName: webhook-issuer-tls
EOF

# Create an Issuer for the LinkerD Webhook Trust Chain in the linkerd-jaeger namespace
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: webhook-issuer
  namespace: linkerd-jaeger
spec:
  ca:
    secretName: webhook-issuer-tls
EOF

# Create a Certificate for the LinkerD Policy Validator
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: linkerd-policy-validator
  namespace: linkerd
spec:
  secretName: linkerd-policy-validator-k8s-tls
  duration: 2160h00m
  renewBefore: 721h00m
  issuerRef:
    name: webhook-issuer
    kind: Issuer
  commonName: linkerd-policy-validator.linkerd.svc
  dnsNames:
  - linkerd-policy-validator.linkerd.svc
  isCA: false
  privateKey:
    rotationPolicy: Always
    algorithm: ECDSA
    encoding: PKCS8
  usages:
  - server auth
EOF

# Create a Certificate for the LinkerD Proxy Injector
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: linkerd-proxy-injector
  namespace: linkerd
spec:
  secretName: linkerd-proxy-injector-k8s-tls
  duration: 2160h00m
  renewBefore: 721h00m
  issuerRef:
    name: webhook-issuer
    kind: Issuer
  commonName: linkerd-proxy-injector.linkerd.svc
  dnsNames:
  - linkerd-proxy-injector.linkerd.svc
  isCA: false
  privateKey:
    rotationPolicy: Always
    algorithm: ECDSA
  usages:
  - server auth
EOF

# Create a Certificate for the LinkerD SP Validator
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: linkerd-sp-validator
  namespace: linkerd
spec:
  secretName: linkerd-sp-validator-k8s-tls
  duration: 2160h00m
  renewBefore: 721h00m
  issuerRef:
    name: webhook-issuer
    kind: Issuer
  commonName: linkerd-sp-validator.linkerd.svc
  dnsNames:
  - linkerd-sp-validator.linkerd.svc
  isCA: false
  privateKey:
    rotationPolicy: Always
    algorithm: ECDSA
  usages:
  - server auth
EOF

# Create a Certificate for the LinkerD Tap
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: tap
  namespace: linkerd-viz
spec:
  secretName: tap-k8s-tls
  duration: 2160h00m
  renewBefore: 721h00m
  issuerRef:
    name: webhook-issuer
    kind: Issuer
  commonName: tap.linkerd-viz.svc
  dnsNames:
  - tap.linkerd-viz.svc
  isCA: false
  privateKey:
    rotationPolicy: Always
    algorithm: ECDSA
  usages:
  - server auth
EOF

# Create a Certificate for the LinkerD Tap Injector
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: linkerd-tap-injector
  namespace: linkerd-viz
spec:
  secretName: tap-injector-k8s-tls
  duration: 2160h00m
  renewBefore: 721h00m
  issuerRef:
    name: webhook-issuer
    kind: Issuer
  commonName: tap-injector.linkerd-viz.svc
  dnsNames:
  - tap-injector.linkerd-viz.svc
  isCA: false
  privateKey:
    rotationPolicy: Always
    algorithm: ECDSA
  usages:
  - server auth
EOF

# Create a Certificate for the LinkerD Jaeger Injector
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: jaeger-injector
  namespace: linkerd-jaeger
spec:
  secretName: jaeger-injector-k8s-tls
  duration: 2160h00m
  renewBefore: 721h00m
  issuerRef:
    name: webhook-issuer
    kind: Issuer
  commonName: jaeger-injector.linkerd-jaeger.svc
  dnsNames:
  - jaeger-injector.linkerd-jaeger.svc
  isCA: false
  privateKey:
    rotationPolicy: Always
    algorithm: ECDSA
  usages:
  - server auth
EOF

```
### Install LinkerD Control Plane

```bash
# Get the generagted webhook issuer ca bundle
export CA_BUNDLE=`kubectl get secret webhook-issuer-tls -n linkerd -o jsonpath="{.data.ca\.crt}" | base64 -d`

# install the LinkerD control plane once the CRDs have been installed
linkerd install \
  --identity-external-issuer \
  --set policyValidator.externalSecret=true \
  --set policyValidator.caBundle="${CA_BUNDLE}" \
  --set proxyInjector.externalSecret=true \
  --set proxyInjector.caBundle="${CA_BUNDLE}" \
  --set profileValidator.externalSecret=true \
  --set profileValidator.caBundle="${CA_BUNDLE}" \
  | kubectl apply -f -

# install the LinkerD Viz extension
linkerd viz install \
  --set tap.externalSecret=true \
  --set tap.caBundle="${CA_BUNDLE}" \
  --set tapInjector.externalSecret=true \
  --set tapInjector.caBundle="${CA_BUNDLE}" \
  | kubectl apply -f -

# install the LinkerD Jaeger extension
linkerd jaeger install \
  --set jaeger.externalSecret=true \
  --set jaeger.caBundle="${CA_BUNDLE}" \
  --set jaegerInjector.externalSecret=true \
  --set jaegerInjector.caBundle="${CA_BUNDLE}" \
  | kubectl apply -f -
```

### Deploy an example application to test the LinkerD Service Mesh

First we will deploy an unmeshed application to our cluster. We will then mesh the application using LinkerD and test the application to ensure that it is working as expected.

```bash
# deploy an unmeshed version of the emojivoto application
kubectl apply -k github.com/BuoyantIO/emojivoto/kustomize/deployment

# view the application in the browser
kubectl -n emojivoto port-forward svc/web-svc 8080:80

# mesh the application using LinkerD
kubectl get -n emojivoto deploy -o yaml \
  | linkerd inject - \
  | kubectl apply -f -

# view the application in the linkerd dashboard
linkerd viz dashboard

# view the application in the browser
kubectl -n emojivoto port-forward svc/web-svc 8080:80

```

### Mesh the Envoy Gateway Controller

```bash
# mesh the Envoy Gateway Controller using LinkerD
kubectl get deployment -n envoy-gateway-system -o yaml envoy-gateway \
  | linkerd inject - \
  | kubectl apply -f -

# configure the Envoy Proxies to use the LinkerD Proxy
cat <<EOF | kubectl apply -f -
apiVersion: gateway.envoyproxy.io/v1alpha1
kind: EnvoyProxy
metadata:
  name: custom-proxy-config
  namespace: envoy-gateway-system
spec:
  provider:
    type: Kubernetes
    kubernetes:
      envoyDeployment:
        pod:
          annotations:
            linkerd.io/inject: enabled
EOF

# Deploy a GatewayClass that uses the custom EnvoyProxy Configuration
cat <<EOF | kubectl apply -f -
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: eg
spec:
  controllerName: gateway.envoyproxy.io/gatewayclass-controller
  parametersRef:
    group: gateway.envoyproxy.io
    kind: EnvoyProxy
    name: custom-proxy-config
    namespace: envoy-gateway-system
EOF
```

### Deploy a Gateway that terminates Publicly Trusted TLS for North-South Traffic
export CERT_MANAGER_CONTACT_EMAIL=$(git config user.email)

```bash
# Deploy a ClusterIssuer
cat <<EOF | kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: "$CERT_MANAGER_CONTACT_EMAIL"
    privateKeySecretRef:
      name: letsencrypt-account-key
    solvers:
    - http01:
        gatewayHTTPRoute:
          parentRefs:
          - kind: Gateway
            name: eg
            namespace: emojivoto
EOF

# Deploy a Gateway and HttpRoute for the Emojivoto application
cat <<EOF | kubectl apply -f -
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: eg
  namespace: emojivoto
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt
    cert-manager.io/revision-history-limit: "3"
spec:
  gatewayClassName: eg
  listeners:
    - name: http
      protocol: HTTP
      port: 80
    - name: https
      protocol: HTTPS
      port: 443
      hostname: "emojivoto.example.rye.ninja"
      tls:
        mode: Terminate
        certificateRefs:
          - kind: Secret
            name: emojivoto-example-rye-ninja-tls
EOF
```
### Delploy a HttpRoute object to route traffic to the Emojivoto application

```bash
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: backend
  namespace: emojivoto
spec:
  parentRefs:
    - name: eg
  hostnames:
    - "emojivoto.example.rye.ninja"
  rules:
    - backendRefs:
        - group: ""
          kind: Service
          name: web-svc
          port: 80
          weight: 1
      matches:
        - path:
            type: PathPrefix
            value: /
EOF

# Get the IP Address of the Gateway
export IP_ADDRESS=`kubectl get gateway -n emojivoto eg -o yaml | yq ".status.addresses[0].value"`

# Test the Gateway
curl -v ${IP_ADDRESS} -H "Host: emojivoto.example.rye.ninja"

# Dump a bunch of traffic through the Gateway and the meshed application
hey -n 50000 -q 60 -host emojivoto.example.rye.ninja http://${IP_ADDRESS}/api/vote\?choice\=:money_mouth_face:

```
