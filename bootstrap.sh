#!/usr/bin/env bash
# https://github.com/crispgm/dotfiles/blob/master/bootstrap
# https://github.com/einverne/dotfiles/blob/master/mac_bootstrap.sh

set -e

echo "Setup hostname"
sudo scutil --set HostName PowerBook

echo "Install Nix"
curl -L https://nixos.org/nix/install | sh

echo "Install Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install with Nix"
set +e
nix profile install ~/dotfiles/nix#default
set -e

echo "Install with Brew Bundle"
set +e
export PATH=$PATH:/opt/homebrew/bin
brew bundle --file ~/dotfiles/homebrew/Brewfile
set -e

echo "Setup Fish Shell"
set +e
echo $(which fish) | sudo tee -a /etc/shells
chsh -s $(which fish)
set -e
