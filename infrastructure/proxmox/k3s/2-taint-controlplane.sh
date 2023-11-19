kubectl taint node -l node-role.kubernetes.io/control-plane=true \
  $(kubectl get node -o json | jq '[ .items[].metadata.name ] | join(" ")' -r) \
  "node-role.kubernetes.io/control-plane:NoSchedule"