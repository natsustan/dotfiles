alias up="brew update && brew upgrade && brew cu -a -y && brew cleanup && mas upgrade && ~/.config/plum/rime-install iDvel/rime-ice:others/recipes/all_dicts"
alias icon="fileicon set /Applications/Alacritty.app/ /Users/spkz/dotfiles/macOSicons/iTerm.icns && fileicon set /Applications/Spotify.app /Users/spkz/dotfiles/macOSicons/Spotify.icns && fileicon set /Applications/Figma.app /Users/spkz/dotfiles/macOSicons/Figma.icns && fileicon set /Applications/Visual\ Studio\ Code.app/ /Users/spkz/dotfiles/macOSicons/Code.icns && fileicon set /Applications/Notion.app/ /Users/spkz/dotfiles/macOSicons/Notion.icns && fileicon set /Applications/kitty.app /Users/spkz/dotfiles/macOSicons/kitty.icns"


alias bi='brew install'
alias bu='brew uninstall'
alias bs='brew search'
alias bl='brew list'
alias bbd='brew bundle dump --file=~/dotfiles/homebrew/Brewfile --force'

alias df="df -h"
alias cp='cp -i'
alias mv="mv -i"
alias rm='rm -i'

alias vz="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias gp="cd ~/Projects"

#alias vi="nvim"
#alias vim="nvim"


# ls
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# misc
alias reload='exec fish'
