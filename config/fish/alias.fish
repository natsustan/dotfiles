alias up="brew update && brew upgrade && brew cu -a -y && brew cleanup && mas upgrade && ~/.config/plum/rime-install iDvel/rime-ice:others/recipes/all_dicts"
alias icon="fileicon set /Applications/kitty.app $HOME/dotfiles/macOSicons/iTerm.icns &&
fileicon set /Applications/Spotify.app $HOME/dotfiles/macOSicons/Spotify.icns &&
fileicon set /Applications/Figma.app $HOME/dotfiles/macOSicons/Figma.icns &&
fileicon set /Applications/Notion.app $HOME/dotfiles/macOSicons/Notion.icns &&
fileicon set /Applications/HandBrake.app $HOME/dotfiles/macOSicons/handbrake.icns &&
sudo fileicon set /Applications/Sequel\ Ace.app $HOME/dotfiles/macOSicons/Sequel_Pro.icns &&
sudo fileicon set /Applications/DingTalk.app $HOME/dotfiles/macOSicons/Dingtalk.icns"
#alias ip="ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'"

alias bi='brew install'
alias bu='brew uninstall'
alias bs='brew search'
alias bl='brew list'
alias bbd='brew bundle dump --file=~/dotfiles/homebrew/Brewfile --force'

alias df="df -h"
alias cp='cp -i'
alias mv="mv -i"
alias rm='rm -i'

#alias vz="vim ~/.zshrc"
#alias sz="source ~/.zshrc"
#alias gp="cd ~/Projects"

alias vi="nvim"
alias vim="nvim"

# ls
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# misc
alias reload='exec fish'