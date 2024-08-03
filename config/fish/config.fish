set -g fish_greeting

source ~/.config/fish/alias.fish

# ENV PATH
set -x PATH /opt/homebrew/bin $PATH
set -x PATH /Users/spike/.nix-profile/bin/ $PATH
set -x PATH /nix/var/nix/profiles/default/bin/ $PATH
set -x PATH /Users/spike/Library/Python/3.9/bin $PATH

# reload fish plugin z from nixos
set -gx fish_function_path $fish_function_path $HOME/.nix-profile/share/fish/vendor_functions.d
source $HOME/.nix-profile/share/fish/vendor_conf.d/z.fish

export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153

starship init fish | source

# ip
function ip
    ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'
end

# pnpm
set -gx PNPM_HOME "/Users/spike/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end


