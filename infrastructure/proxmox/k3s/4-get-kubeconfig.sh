scp controlplane01.infra.usmnblm01.rye.ninja:/etc/rancher/k3s/k3s.yaml ~/.kube/k3s.yaml
sed -I '' 's|https://127.0.0.1:6443|https://k8s.infra.usmnblm01.rye.ninja:6443|g' ~/.kube/k3s.yaml