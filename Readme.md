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

### fish 

```
ln -s ~/dotfiles/config/fish/config.fish ~/.config/fish/
ln -s ~/dotfiles/config/fish/alias.fish ~/.config/fish/
```

### zsh

#### Symlink

```
ln -s ~/dotfiles/config/zsh/zshrc ~/.zshrc
```

#### Commands

```
mkdir -p ~/.local/bin
ln -s ~/dotfiles/bin/tdl ~/.local/bin/tdl
```

### hammerspoon

setting the location of configuration files

```
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/dotfiles/hammerspoon/init.lua"
```

<!-- ### Firefox


```
ln -s ~/dotfiles/firefox/chrome ~/Library/Application\ Support/Firefox/Profiles/xxx.default-release/
``` -->


### git

```
git config --global core.excludesfile ~/dotfiles/git/gitignore_global
```

### ghostty

```
ln -s ~/dotfiles/config/ghostty ~/.config/ghostty
ln -s ~/dotfiles/config/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config
```

### Cursor

```
ln -s ~/dotfiles/config/cursor/settings.json ~/Library/Application\ Support/Cursor/User/settings.json
```

### Zed

```
ln -s ~/dotfiles/config/zed/settings.json ~/.config/zed/settings.json
```

### Agents

```
mkdir -p ~/.config/amp ~/.pi/agent

ln -sf ~/dotfiles/agents/AGENTS.md ~/.config/amp/AGENTS.md
ln -sf ~/dotfiles/agents/AGENTS.md ~/.pi/agent/AGENTS.md
```

### Others

#### 使用 Touch ID 认证 sudo

```
sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
sudo chmod +w /etc/pam.d/sudo_local
sudo vim /etc/pam.d/sudo_local
```
