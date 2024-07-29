alias up="brew update && brew upgrade && brew cu -a -y && brew cleanup && mas upgrade && ~/.config/plum/rime-install iDvel/rime-ice:others/recipes/all_dicts"
alias icon="fileicon set /Applications/kitty.app $HOME/dotfiles/macOSicons/iTerm.icns &&
fileicon set /Applications/Figma.app $HOME/dotfiles/macOSicons/Figma.icns &&
fileicon set /Applications/HandBrake.app $HOME/dotfiles/macOSicons/handbrake.icns &&
fileicon set /Applications/Logseq.app $HOME/dotfiles/macOSicons/Logseq.icns &&
fileicon set /Applications/GitHub\ Desktop.app/ ~/dotfiles/macOSicons/github.icns"

# fileicon set /Applications/Notion.app $HOME/dotfiles/macOSicons/Notion.icns &&
# fileicon set /Applications/Spotify.app $HOME/dotfiles/macOSicons/Spotify.icns &&

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

# ls
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# misc
alias reload='exec fish'

alias rime='/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --reload'
