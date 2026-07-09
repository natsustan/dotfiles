# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS dotfiles for `natsustan/dotfiles`. Configs are deployed via manual symlinks from this repo to their expected system locations (see `Readme.md` for all symlink commands).

## Structure

- `config/` — XDG-style configs: `fish/`, `zsh/`, `tmux/`, `nvim/`, `ghostty/`, `kitty/`, `starship/`, `mise/`, `cursor/`, `zed/`
- `git/` — gitconfig and global gitignore
- `hammerspoon/` — macOS automation (Spoons: Vifari, DoubleQToQuit, AppAutoQuits, etc.)
- `rime/` — Chinese input method engine configs (ice schema)
- `homebrew/` — Brewfile for declarative package management
- `bin/` — custom scripts (notably `tdl`)
- `macOSicons/` — custom app icons (.icns)

## Key Commands

```bash
# Install all packages
cd ~/dotfiles/homebrew && brew bundle

# Install tool runtimes (node, bun, neovim, starship, tmux, eza, lazygit, etc.)
mise install
```

## tdl — Tmux Dev Layout

`bin/tdl` creates a tmux session with a predefined layout: main editor pane (left), lazygit + yazi + terminal (right). Supports up to two AI coding agents as arguments.

```bash
tdl claude          # single agent
tdl claude amp      # two agents side-by-side
```

Supported agents: `amp`, `codex`, `claude`, `opencode`, `pi`, `droid`

## Conventions

- **Primary shell:** fish (set as default in tmux and terminals)
- **Vi keybinds:** used in tmux, shells, and editors consistently
- **Fonts:** Berkeley Mono / iA Writer Duo across terminals and editors
- **Themes:** GitHub Light/Dark family; system appearance detection enabled
- **Some config files contain Chinese comments** (Hammerspoon, Ghostty, Rime)
- **No automated installer** — all setup is manual symlinks per Readme.md
