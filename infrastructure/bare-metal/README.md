# Bare Metal Lab Provisioning

## Building images for Bare Metal Lab

```bash
LAB_AUTOMATION_DIR=`realpath .`

mkdir -p ${LAB_AUTOMATION_DIR}/iso/output ${LAB_AUTOMATION_DIR}/iso/cidata ${LAB_AUTOMATION_DIR}/iso/ubuntu-iso

docker run --rm -it \
  --mount type=bind,source=${LAB_AUTOMATION_DIR}/iso/output,target=/output \
  --mount type=bind,source=${LAB_AUTOMATION_DIR}/iso/cidata,target=/tmp/cidata \
  --mount type=bind,source=${LAB_AUTOMATION_DIR}/iso/ubuntu-iso,target=/tmp/ubuntu-iso \
  --mount type=bind,source=${LAB_AUTOMATION_DIR}/host-images/inventories,target=/inventories,readonly \
  --mount type=bind,source=${LAB_AUTOMATION_DIR}/host-images/group_vars,target=/ansible/playbooks/group_vars,readonly \
  --mount type=bind,source=${LAB_AUTOMATION_DIR}/host-images/host_vars,target=/ansible/playbooks/host_vars,readonly \
  --entrypoint ansible-playbook \
  estenrye/ubuntu-autoinstall-iso \
    -i /inventories/image-inventory.yml \
    --skip-tags packer,proxmox-upload \
    /ansible/playbooks/playbook.yml
```

## Hardening Bare Metal Nodes

```bash
LAB_AUTOMATION_DIR=`realpath .`

docker pull estenrye/ubuntu-autoinstall-iso:latest

docker run --rm -it \
  --mount type=bind,source=${LAB_AUTOMATION_DIR},target=/inventories,readonly \
  --mount type=bind,source=${HOME}/.ssh/home_id_rsa,target=/root/.ssh/id_rsa,readonly \
  --entrypoint ansible-playbook \
  estenrye/ubuntu-autoinstall-iso:latest \
    -i /inventories/inventory.yml \
    -e ubuntu_2004_cis_require_ssh_allowusers=automation-user \
    -e ubuntu_2004_cis_require_ssh_allowgroups=automation-user \
    -e ubuntu_2004_cis_require_ssh_denyusers=bogus \
    -e ubuntu_2004_cis_require_ssh_denygroups=bogus \
    -u automation-user \
    /ansible/playbooks/_hardening/apply-hardening.yml
```