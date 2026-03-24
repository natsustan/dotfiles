/opt/homebrew/bin/brew shellenv | source
~/.local/bin/mise activate fish | source
starship init fish | source

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

alias up='brew update && brew upgrade && brew cleanup && mas upgrade && ~/.config/plum/rime-install iDvel/rime-ice:others/recipes/all_dicts'
alias ip='ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk \'{print $2}\''

