# Proxmox Node Preparation

## Execute the Ansible Playbook

```bash
docker-compose --file ${HOME}/src/cd-homelab/docker-compose/tools.rye.ninja/docker-compose.yaml \
  up --detach --no-recreate

export OP_CONNECT_TOKEN=`op read op://Home_Lab/1Password-Connect-Token-usmnblm01.rye.ninja/credential`

ansible-playbook \
  -i ${HOME}/src/cd-homelab/infrastructure/proxmox/prep-vm-image/inventory.yaml \
  ${HOME}/src/cd-homelab/infrastructure/proxmox/prep-vm-image/install-vm-templates.yaml
```