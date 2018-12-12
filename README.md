# Dotfiles

A simple collection of my unix configuration files.

## Installation

```
git clone --recursive https://github.com/juanwolf/dotfiles.git
./install.sh -f
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
* nvim
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
* Navigation with alt + arrows key
* Pane synchronization with Ctrl + A, Ctrl + S
* Basic theme configuration.

### Zsh

* Using oh-my-zsh
* Agnoster theme
* Mainly python, django, docker plugins enabled

### Vim

* VimPlug as plugin manager, main commands bellow:
  * :PlugClean
  * :PlugInstall
  * :PlugUpdate
* Easier navigation with Ctrl + h,j,k,l between panes
* Solarized theme
  * **Shortcut**: F6 to switch between dark/light mode
* Nerdtree
  * **Shortcut**: F3
* YouCompleteMe + custom installation (python + go + js)
  * **Important**: You need npm + nodejs to be installed for the js support.
* Syntastic
* CtrlP
* tagbar
  * **Shortcut**: F8
* Vim fugitive (Git commands) + Git Gutter, main commands:
  * :Gpull
  * :Gpush
  * :Gcommit
* Airline
* Dev icons
  * **Important**: You need Nerd Fonts to be installed on your local environment (https://github.com/ryanoasis/vim-devicons)
* Tags with vim-tags
  * :TagsGenerate
  * Jump to definition (class, function) -> Ctrl + n
* Markdown Live Preview
  * `:InstantMarkdownPreview` to get a live preview of your markdown
