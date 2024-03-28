if status is-interactive
    # Commands to run in interactive sessions can go here
set -g fish_greeting
export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153

source ~/.config/fish/alias.fish

set -x PATH /opt/homebrew/bin $PATH
set -x PATH /Users/spkz/.nix-profile/bin $PATH
set -x PATH /nix/var/nix/profiles/default/bin/ $PATH

end
