alias up="brew update && brew upgrade && brew cu -a -y && brew cleanup && mas upgrade"
alias icon="fileicon set /Applications/Figma.app $HOME/dotfiles/macOSicons/Figma.icns &&
fileicon set /Applications/GitHub\ Desktop.app/ $HOME/dotfiles/macOSicons/GitHub\ Desktop.icns &&
fileicon set /Applications/AppCleaner.app $HOME/dotfiles/macOSicons/AppCleaner.icns &&
fileicon set /Applications/ChatWise.app $HOME/dotfiles/macOSicons/ChatWise.icns &&
sudo fileicon set /Applications/Tunnelblick.app $HOME/dotfiles/macOSicons/tunnelbrick.icns"

alias bi='brew install'
alias bu='brew uninstall'
alias bs='brew search'
alias bl='brew list'
alias bbd='brew bundle dump --file=~/dotfiles/homebrew/Brewfile --force'

alias df="df -h"
alias cp='cp -i'
alias mv="mv -i"
alias rm='rm -i'

alias vi="nvim"
alias vim="nvim"

alias cd..="cd .."
alias cd...="cd ../.."
alias cd....="cd ../../.."
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ls
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# misc
alias vz='vim ~/.config/fish/config.fish'
alias sz='source ~/.config/fish/config.fish'

# ip
# alias ip="ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}'"
