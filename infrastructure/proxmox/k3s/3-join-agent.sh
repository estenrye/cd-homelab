apt update && apt upgrade -y && apt install -y curl jq
curl -sfL https://get.k3s.io | K3S_TOKEN=20jf89pn8h80h4320ghn34g80nvefopr82340h sh -s - agent \
 --server=https://k8s.infra.usmnblm01.rye.ninja:6443
