# Set the cluster name. This is used to look up the join token in 1password.
export CLUSTER_NAME=argocd
export CLUSTER_VIP='10.5.12.0'

# Create a new cluster secret in 1password. This is used to join the server to the cluster.
op item create \
  --account=ryefamily.1password.com \
  --vault=Home_Lab \
  --category="Password" \
  --title=k3s-join-token.${CLUSTER_NAME}.usmnblm01.rye.ninja \
  --tags=k3s \
  --generate-password \
  k8s-cluster-vip=${CLUSTER_VIP} \
  url=k8s.${CLUSTER_NAME}.usmnblm01.rye.ninja


apt update && apt upgrade -y && apt install -y curl jq
curl -sfL https://get.k3s.io | K3S_TOKEN=`op read --account ryefamily.1password.com op://Home_Lab/k3s-join-token.${CLUSTER_NAME}.usmnblm01.rye.ninja/password` sh -s - server \
 --cluster-init \
 --tls-san=127.0.0.1 \
 --tls-san=`op read --account ryefamily.1password.com op://Home_Lab/k3s-join-token.${CLUSTER_NAME}.usmnblm01.rye.ninja/k8s-cluster-vip` \
 --tls-san=$(hostname) \
 --tls-san=$(hostname).usmnblm01.rye.ninja \
 --tls-san=k8s.${CLUSTER_NAME}.usmnblm01.rye.ninja \
 --disable=servicelb \
 --disable=traefik \
 --write-kubeconfig-mode=644
