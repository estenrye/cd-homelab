# CD-HOMELAB

This repo contains my argo-cd continuous deployment code.

## Preparing Your Development Environment

1. Install curl and git
   ```bash
   sudo apt update && sudo apt install -y \
     build-essential \
     curl \
     git \
     vim
   ```

1. Configure git
   ```bash
   git config --global user.email "you@example.com"
   git config --global user.name "Your Name"
   git config --global core.editor vim
   ```

1. Install vscode and plugins
   ```bash
   sudo snap install --classic code
   code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools
   code --install-extension Gruntfuggly.todo-tree
   ```

1. Install homebrew
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ${HOME}/.profile
   eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
   ```

1. Clone this repository
   ```bash
   git clone git@github.com:estenrye/cd-homelab.git
   ```

1. Install tools
   ```bash
   cd cd-homelab
   brew bundle
   ```

1. If on Linux, Install 1password-cli separately.

   https://developer.1password.com/docs/cli/get-started/

1. Install krew
   ```bash
   (
      set -x; cd "$(mktemp -d)" &&
      OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
      ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
      KREW="krew-${OS}_${ARCH}" &&
      curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
      tar zxvf "${KREW}.tar.gz" &&
      ./"${KREW}" install krew
   )
   echo 'export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"' >> ${HOME}/.profile
   export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
   ```

1. Install kubectl extensions
   ```bash
   kubectl krew install \
     cert-manager \
     neat
   ```

## Preparing an AWS Environment

1. Install prerequisites

```bash
brew bundle
./configure-local-env.sh
source ~/.zshrc
```

1. Install Python 3.10.6 and required packages.

```bash
pyenv install 3.10.6
pyenv local 3.10.6
pyenv exec pip install --upgrade pip
pyenv exec pip install -r ./requirements.txt
pyenv exec ansible-galaxy install -r ./requirements.yml
```

1. Configure your `~/.ssh/config` for SSH Agent Forwarding

```
Host *.compute.amazonaws.com
  ForwardAgent yes
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null

Host *.compute.internal
  StrictHostKeyChecking no
  UserKnownHostsFile=/dev/null
```

### Deploying

```bash
export TAG_OWNER='Your Name'
export TAG_TEAM='Your Team'
export KEY_NAME='your-key-name-in-aws'
export AWS_PROFILE='hybrid-dev'

# Provision Infrastructure

pyenv exec ansible-playbook -i localhost, infrastructure/aws/provision.yml

ANSIBLE_CONFIG=config/ansible.cfg pyenv exec \
  ansible-playbook \
    -i infrastructure/aws/inventory.aws_ec2.yml \
    infrastructure/aws/mount_disks.yml

# Provision a Nodelet Cluster

ANSIBLE_CONFIG=config/ansible.cfg pyenv exec \
  ansible-playbook \
    -i infrastructure/aws/inventory.aws_ec2.yml \
    infrastructure/nodelet-cluster/playbook.yml

```

# ##Destroying

```bash
export TAG_OWNER='Your Name'
export TAG_TEAM='Your Team'
export KEY_NAME='your-key-name-in-aws'
export AWS_PROFILE='hybrid-dev'

pyenv exec ansible-playbook -i localhost, infrastructure/aws/destroy.yml
```

