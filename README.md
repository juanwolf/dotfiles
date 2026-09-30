# Dotfiles

A simple collection of my unix configuration files.

## Installation

```
git clone --recursive https://github.com/juanwolf/dotfiles.git
./install.sh -f
tic -x -o ~/.terminfo ~/.xterm-24bit.terminfo
```
And there you go.

**Warning**: The script will erase your previous configuration with the `-f` option.

### Dependencies

You'll need to have some repository installed before having this configuration to be fully working:

#### Fonts (required)

* Nerd fonts

#### Shell (required)

* zsh (oh-my-zsh included with this repo)
* tmux
* Neovim (LazyVim; current stable release recommended)
* git (for LazyVim's plugin bootstrap)
* nodejs
* rust (with rustup)
* python & virtualenvwrapper

#### i3 (optional)

* i3-gaps
* [i3status-rust](https://github.com/greshake/i3status-rust)
* playctl
* Termite
* rofi

## How to use it?

### i3
* Main key: Super
* Print key: Screenshot
* Super+q: quit
* super+d: Search and run binary
* super+<enter>: Start terminal
* TODO: Add all the i3 bindings

### Tmux

#### Default Features

* Main key: Ctrl + A
* Navigate panes with Alt + Arrow (Option + Arrow on macOS). Ghostty sends these keys to tmux using the mappings in [.config/ghostty/config](.config/ghostty/config).
* Pane synchronization with Ctrl + A, Ctrl + S
* Basic theme configuration.

### Zsh

* Using oh-my-zsh
* Agnoster theme
* Mainly python, django, docker plugins enabled

### Neovim and Pi

Neovim uses [LazyVim](https://www.lazyvim.org/) with lazy.nvim. Run `./install.sh -n` to preview the links, then `./install.sh -f` to install. If `~/.config/nvim` already exists as a real directory, `-f` backs it up before linking this config. The install hook runs `:Lazy sync`; you can run it again in Neovim after changing plugins.

Open Neovim in the same Git working tree where Pi is editing. Press `<Space>gv` (or run `:DiffviewOpen`) for a side-by-side view of uncommitted changes; `<Space>gV` closes it. LazyVim's built-in gitsigns also marks changed lines in normal buffers. When you return focus to Neovim, externally changed buffers reload through `:checktime`. In the Diffview file panel, press `R` to refresh its file list after Pi makes further edits.

The old `.vimrc` remains available for Vim, but Neovim no longer sources it.

Pi's global settings live in `.pi/agent/settings.json`. They select `openai/gpt-6.1-sol` with high thinking and retain the existing theme and extension packages. `.pi/agent/models.json` keeps the current provider gateway URLs. Pi authentication remains in `~/.pi/agent/auth.json` and is not stored in this repository.
