# dotfiles

My macOS Configuration Files

### homebrew 

```
cd ~/dotfiles/homebrew && brew bundle
```

### Rime

Rime, a powerful Chinese Input Method Engine.

#### Symlink

```
rm -rf ~/Library/Rime
ln -s ~/dotfiles/rime ~/Library
```

#### Tips

Use `control + ~` to adjust Traditional/Simplified Chinese.

### Alacritty

#### Symlink

```
ln -s ~/dotfiles/config/alacritty ~/.config
```

### zsh

#### Symlink

```
ln -s ~/dotfiles/zsh/zshrc ~/.zshrc
```

### hammerspoon

setting the location of configuration files

```
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/dotfiles/hammerspoon/init.lua"
```

### Firefox


```
ln -s ~/dotfiles/firefox/chrome ~/Library/Application\ Support/Firefox/Profiles/xxx.default-release/
```

### Tmux

```
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```

### kitty

```
ln -s ~/dotfiles/config/kitty ~/.config/
```

### git

```
git config --global core.excludesfile ~/dotfiles/git/gitignore_global
```

### Others

#### 使用 Touch ID 认证 sudo

```
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sudo chmod +w /etc/pam.d/sudo_local
sudo vim /etc/pam.d/sudo_local
```
