argocd app create linkerd-cni \
  --project service \
  --repo https://github.com/estenrye/cd-homelab.git \
  --path applications/linkerd \
  --dest-namespace linkerd \
  --dest-server https://kubecon.platform9.net/sunpike/apis/opt.pf9.io/v1beta1/namespaces/default/clusters/esten-kubecon-test/proxy \
  --sync-option CreateNamespace=true \
  --revision HEAD

PROJECT=service
CLUSTER=https://kubecon.platform9.net/sunpike/apis/opt.pf9.io/v1beta1/namespaces/default/clusters/esten-kubecon-test/proxy

LINKERD_REPO_URL=https://helm.linkerd.io/stable
LINKERD_CNI_VERSION=30.3.4
LINKERD_VIZ_VERSION=30.3.4
LINKERD_CRD_VERSION=1.4.0
LINKERD_CTL_VERSION=1.9.4

CERTMANAGER_REPO_URL=https://charts.jetstack.io
CERTMANAGER_VERSION=v1.9.1


argocd repo add ${LINKERD_REPO_URL} --type helm --name linkerd-stable --upsert
argocd proj add-source ${PROJECT} ${LINKERD_REPO_URL}
argocd app create linkerd-cni \
  --project ${PROJECT} \
  --repo ${LINKERD_REPO_URL} \
  --helm-chart linkerd2-cni \
  --revision ${LINKERD_CNI_VERSION} \
  --dest-namespace linkerd-cni \
  --dest-server ${CLUSTER} \
  --sync-option CreateNamespace=true \
  --upsert
argocd app create linkerd-crd \
  --project ${PROJECT} \
  --repo ${LINKERD_REPO_URL} \
  --helm-chart linkerd-crds \
  --revision ${LINKERD_CRD_VERSION} \
  --dest-server ${CLUSTER} \
  --upsert
step certificate create root.linkerd.cluster.local tmp/ca.crt tmp/ca.key \
  --profile root-ca \
  --no-password \
  --insecure
step certificate create identity.linkerd.cluster.local tmp/issuer.crt tmp/issuer.key \
  --profile intermediate-ca \
  --not-after 8760h \
  --no-password \
  --insecure \
  --ca tmp/ca.crt \
  --ca-key tmp/ca.key
helm repo add linkerd ${LINKERD_REPO_URL} --force-update
helm fetch --untar linkerd/linkerd-control-plane --version ${LINKERD_CTL_VERSION} --untardir tmp
argocd app create linkerd-control-plane \
  --project ${PROJECT} \
  --repo ${LINKERD_REPO_URL} \
  --helm-chart linkerd-control-plane \
  --revision ${LINKERD_CTL_VERSION} \
  --dest-namespace linkerd \
  --dest-server ${CLUSTER} \
  --sync-option CreateNamespace=true \
  --upsert \
  --helm-set-file identityTrustAnchorsPEM=tmp/ca.crt \
  --helm-set-file identity.issuer.tls.crtPEM=tmp/issuer.crt \
  --helm-set-file identity.issuer.tls.keyPEM=tmp/issuer.key \
  --values-literal-file tmp/linkerd-control-plane/values-ha.yaml
argocd app create linkerd-viz \
  --project ${PROJECT} \
  --repo ${LINKERD_REPO_URL} \
  --helm-chart linkerd-viz \
  --revision ${LINKERD_VIZ_VERSION} \
  --dest-namespace linkerd-viz \
  --dest-server ${CLUSTER} \
  --sync-option CreateNamespace=true \
  --upsert

argocd repo add ${CERTMANAGER_REPO_URL} --type helm --name linkerd-stable --upsert
argocd proj add-source ${PROJECT} ${CERTMANAGER_REPO_URL}

argocd app create cert-manager \
  --repo ${CERTMANAGER_REPO_URL} \
  --helm-chart cert-manager \
  --revision ${CERTMANAGER_VERSION} \
  --dest-namespace cert-manager \
  --dest-server ${CLUSTER} \
  --sync-option CreateNamespace \
  --upsert \
  --helm-set global.logLevel=2 \
  --helm-set installCRDs=true