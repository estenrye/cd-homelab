export CLUSTER_NAME=argocd

apt update && apt upgrade -y && apt install -y curl jq
curl -sfL https://get.k3s.io | \
  K3S_TOKEN=`op read --account ryefamily.1password.com op://Home_Lab/k3s-join-token.${CLUSTER_NAME}.usmnblm01.rye.ninja/password` sh -s - agent \
    --server=https://k8s.infra.usmnblm01.rye.ninja:6443
