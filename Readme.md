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
ln -s ~/dotfiles/rime ~/Library
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
cd /Users/xxx/Library/Application Support/Firefox/Profiles/xxx.default-release
ln -s ~/dotfiles/firefox/userChrome.css
```

### Tmux
```
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
```

### kitty
```
ln -s ~/dotfiles/kitty ~/.config/
```

