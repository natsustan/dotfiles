/opt/homebrew/bin/brew shellenv | source
~/.local/bin/mise activate fish | source
starship init fish | source
zoxide init fish | source
source "$HOME/.cargo/env.fish"

set -U fish_greeting

alias bi='brew install'
alias bu='brew uninstall'
alias bs='brew search'
alias bl='brew list'
alias bbd='brew bundle dump --file=~/dotfiles/homebrew/Brewfile --force'

alias df='df -h'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ls='eza -F'
alias l='eza -l'
alias la='eza -a'
alias ll='eza -la'
alias lt='ls -lhtrF'
alias l.='ls -lhtrdF .*'
alias lla='ls -la'

alias z='cd'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias config='vim ~/.config/fish/config.fish'
alias reload='source ~/.config/fish/config.fish'

alias vi='nvim'
alias vim='nvim'

alias up='brew update && brew upgrade && brew cu -a -y && brew cleanup && mas upgrade && amp update && pi update && codex update'
alias ip='ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk \'{print $2}\''

alias icon='fileicon set /Applications/kitty.app ~/dotfiles/macOSicons/kitty.icns && killall Dock'

alias claude='claude --dangerously-skip-permissions'
alias claudetg="claude --channels plugin:telegram@claude-plugins-official  --dangerously-skip-permissions"
alias codex='codex --dangerously-bypass-approvals-and-sandbox'

alias surge-cli='/Applications/Surge.app/Contents/Applications/surge-cli'

# opencode
fish_add_path /Users/spike/.opencode/bin

export https_proxy=http://127.0.0.1:6152;export http_proxy=http://127.0.0.1:6152;export all_proxy=socks5://127.0.0.1:6153

# Added by Antigravity CLI installer
set -gx PATH "/Users/spike/.local/bin" $PATH

# >>> grok installer >>>
fish_add_path $HOME/.grok/bin
# <<< grok installer <<<
