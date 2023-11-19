apt update && apt upgrade -y && apt install -y curl jq
curl -sfL https://get.k3s.io | K3S_TOKEN=20jf89pn8h80h4320ghn34g80nvefopr82340h sh -s - server \
 --server=https://k8s.infra.usmnblm01.rye.ninja:6443 \
 --tls-san=127.0.0.1 \
 --tls-san=10.5.216.0 \
 --tls-san=$(hostname) \
 --tls-san=$(hostname).infra.usmnblm01.rye.ninja \
 --tls-san=k8s.infra.usmnblm01.rye.ninja \
 --disable=servicelb \
 --disable=traefik \
 --write-kubeconfig-mode=644
