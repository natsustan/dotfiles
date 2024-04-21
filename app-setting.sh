ln -s ~/dotfiles/rime ~/Library
ln -s ~/dotfiles/fish ~/.config
ln -s ~/dotfiles/nix ~/.config
ln -s ~/dotfiles/config/kitty ~/.config
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
git config --global core.excludesfile ~/dotfiles/git/gitignore_global
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/dotfiles/hammerspoon/init.lua"
