# CD-HOMELAB

This repo contains my argo-cd continuous deployment code.

## Preparing Your Development Environment

1. Install curl and git
   ```bash
   sudo apt update && sudo apt install -y \
     build-essential \
     curl \
     git
   ```

1. Install vscode
   ```bash
   sudo snap install --classic code
   ```

1. Install homebrew
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ${HOME}
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