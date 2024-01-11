export CLUSTER_NAME=argocd

apt update && apt upgrade -y && apt install -y curl jq
curl -sfL https://get.k3s.io | \
  K3S_TOKEN=`op read --account ryefamily.1password.com op://Home_Lab/k3s-join-token.${CLUSTER_NAME}.usmnblm01.rye.ninja/password` sh -s - server \
    --server=https://k8s.argocd.usmnblm01.rye.ninja:6443 \
    --tls-san=127.0.0.1 \
    --tls-san=`op read --account ryefamily.1password.com op://Home_Lab/k3s-join-token.${CLUSTER_NAME}.usmnblm01.rye.ninja/k8s-cluster-vip` \
    --tls-san=$(hostname) \
    --tls-san=$(hostname).usmnblm01.rye.ninja \
    --tls-san=k8s.${CLUSTER_NAME}.usmnblm01.rye.ninja \
    --disable=servicelb \
    --disable=traefik \
    --write-kubeconfig-mode=644
